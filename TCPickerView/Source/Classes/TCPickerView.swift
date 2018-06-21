//
//  TCPickerView.swift
//  TCPickerView
//
//  Created by Taras Chernyshenko on 9/4/17.
//  Copyright © 2017 Taras Chernyshenko. All rights reserved.
//

import UIKit

public protocol TCPickerViewOutput: class {
    func pickerView(_ pickerView: TCPickerViewInput, didSelectRowAtIndex index: Int)
    func pickerView(_ pickerView: TCPickerViewInput,
        cellForRowAt indexPath: IndexPath) -> (UITableViewCell & TCPickerCellType)?
}

public extension TCPickerViewOutput {
    func pickerView(_ pickerView: TCPickerViewInput,
        cellForRowAt indexPath: IndexPath) -> (UITableViewCell & TCPickerCellType)? {
        return nil
    }
}

public protocol TCPickerViewInput {
    var values: [TCPickerView.Value] { set get }
    var selection: TCPickerView.Mode { set get } // none / single / multiply
    var completion: TCPickerView.Completion? { set get } // use it to get result after user press Done
    var delegate: TCPickerViewOutput? { set get }
    
    var title: String { set get }
    var theme: TCPickerViewThemeType { set get }
    
    init(size: CGSize?) // desing your own picker size
    func show()
    func register(_ nib: UINib?, forCellReuseIdentifier identifier: String)
    func dequeue(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell & TCPickerCellType
}

open class TCPickerView: UIView, UITableViewDataSource, UITableViewDelegate, TCPickerViewInput {
    
    public enum Mode {
        case none
        case single
        case multiply
    }
    
    public struct Value {
        public let title: String
        public var isChecked: Bool
        
        public init(title: String, isChecked: Bool = false) {
            self.title = title
            self.isChecked = isChecked
        }
    }
    
    public typealias Completion = ([Int]) -> Void
    fileprivate let tableViewCellIdentifier = "TableViewCell"
    fileprivate var titleLabel: UILabel?
    fileprivate var doneButton: UIButton?
    fileprivate var closeButton: UIButton?
    fileprivate var containerView: UIView?
    fileprivate var centerXConstraint: NSLayoutConstraint?
    fileprivate var centerYConstraint: NSLayoutConstraint?
    fileprivate var tableView: UITableView?
    fileprivate var headerSeparator: UIView?
    fileprivate var headerHC: NSLayoutConstraint?
    
    public var values: [Value] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }

    public var title: String = "Select" {
        didSet {
            self.titleLabel?.text = self.title
        }
    }
    
    public weak var delegate: TCPickerViewOutput?
    
    public var completion: Completion?
    public var selection: Mode = .multiply
    public var theme: TCPickerViewThemeType = TCPickerViewDefaultTheme() {
        didSet {
            self.updateUI()
        }
    }

    convenience init() {
        self.init(size: nil)
    }
    
    public required init(size: CGSize? = nil) {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let frame: CGRect = CGRect(x: 0, y: 0, width: screenWidth,
            height: screenHeight)

        let width: CGFloat = screenWidth - 84
        let height: CGFloat = 400
        var containerFrame: CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        if let size = size {
            containerFrame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        }
        super.init(frame: frame)
        self.initialize(frame: containerFrame)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize(frame: CGRect.zero)
    }

    fileprivate func initialize(frame: CGRect) {
        self.containerView = UIView(frame: frame)
        self.doneButton = UIButton(frame: CGRect.zero)
        self.closeButton = UIButton(frame: CGRect.zero)
        self.titleLabel = UILabel(frame: CGRect.zero)
        self.tableView = UITableView(frame: CGRect.zero)
        self.headerSeparator = UIView(frame: CGRect.zero)
        
        self.tableView?.register(TCPickerTableViewCell.self,
            forCellReuseIdentifier: self.tableViewCellIdentifier)
        self.tableView?.tableFooterView = UIView()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        self.doneButton?.addTarget(self, action: #selector(TCPickerView.done),
            for: .touchUpInside)
        self.closeButton?.addTarget(self, action: #selector(TCPickerView.close),
            for: .touchUpInside)
        self.setupUI()
        self.updateUI()
    }
    
    open func show() {
        guard let appDelegate = UIApplication.shared.delegate else {
            assertionFailure()
            return
        }
        guard let window = appDelegate.window else {
            assertionFailure()
            return
        }
        
        window?.addSubview(self)
        window?.bringSubview(toFront: self)
        window?.endEditing(true)
        UIView.animate(withDuration: 0.3, delay: 0.0,
            usingSpringWithDamping: 0.7, initialSpringVelocity: 3.0,
            options: .allowAnimatedContent, animations: {
            self.containerView?.center = self.center
            self.tableView?.reloadData()
        }) { (isFinished) in
            self.layoutIfNeeded()
        }
    }
    
    open func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        self.tableView?.register(nib, forCellReuseIdentifier: identifier)
    }
    
    open func registerCell(_ cellClass: Swift.AnyClass?, forCellReuseIdentifier identifier: String) {
        self.tableView?.register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    open func dequeue(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell & TCPickerCellType {
        return self.tableView!.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! UITableViewCell & TCPickerCellType
    }
    
    @objc private func done() {
        var indexes: [Int] = []
        for i in 0..<self.values.count {
            if self.values[i].isChecked {
                indexes.append(i)
            }
        }
        self.completion?(indexes)
        self.close()
    }
    
    @objc private func close() {
        UIView.animate(withDuration: 0.7, delay: 0.0,
            usingSpringWithDamping: 1, initialSpringVelocity: 1.0,
            options: .allowAnimatedContent, animations: {
            self.containerView?.center = CGPoint(x: self.center.x,
            y: self.center.y + self.frame.size.height)
        }) { (isFinished) in
            self.removeFromSuperview()
        }
    }
    
    //MARK: UITableViewDataSource methods
    
    public func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
        return self.values.count
    }
    
    public func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let value = self.values[indexPath.row]
        var cell: UITableViewCell & TCPickerCellType = tableView.dequeueReusableCell(withIdentifier:
            self.tableViewCellIdentifier, for: indexPath) as! TCPickerTableViewCell
        if let customCell = self.delegate?.pickerView(self, cellForRowAt: indexPath) {
            cell = customCell
        }
        cell.viewModel = TCPickerModel(
            title: value.title,
            isChecked: value.isChecked
        )
        return cell
    }
    
    //MARK: UITableViewDelegate methods
    
    public func tableView(_ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        var values = self.values
        switch self.selection {
            case .none: return
            case .single:
                for i in 0..<values.count {
                    values[i].isChecked = false
                }
                values[indexPath.row].isChecked = true
            case .multiply:
                values[indexPath.row].isChecked = !values[indexPath.row].isChecked
        }
        self.values = values
        self.delegate?.pickerView(self, didSelectRowAtIndex: indexPath.row)
    }
}

//MARK: - Appearance

extension TCPickerView {
    fileprivate func setupUI() {
        guard let containerView = self.containerView,
            let doneButton = self.doneButton,
            let closeButton = self.closeButton,
            let titleLabel = self.titleLabel,
            let tableView = self.tableView,
            let headerSeparator = self.headerSeparator else {
                return
        }
        
        self.addSubview(containerView)
        containerView.addSubview(doneButton)
        containerView.addSubview(closeButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(tableView)
        containerView.addSubview(headerSeparator)
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        headerSeparator.translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView?.center = CGPoint(x: self.center.x,
            y: self.center.y + self.frame.size.height)
        
        //titles
        containerView.addConstraint(NSLayoutConstraint(item: titleLabel,
            attribute: .top, relatedBy: .equal, toItem: containerView,
            attribute: .top, multiplier: 1.0, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: titleLabel,
            attribute: .leading, relatedBy: .equal, toItem: containerView,
            attribute: .leading, multiplier: 1.0, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: titleLabel,
            attribute: .trailing, relatedBy: .equal, toItem: containerView,
            attribute: .trailing, multiplier: 1.0, constant: 0))
        self.headerHC = NSLayoutConstraint(item: titleLabel,
                           attribute: .height, relatedBy: .equal, toItem: nil,
                           attribute: .height, multiplier: 1.0, constant: 70)
        titleLabel.addConstraint(self.headerHC!)
        
        headerSeparator.addConstraint(NSLayoutConstraint(item: headerSeparator,
            attribute: .height, relatedBy: .equal, toItem: nil,
            attribute: .height, multiplier: 1.0, constant: 0.5))
        containerView.addConstraint(NSLayoutConstraint(item: headerSeparator,
            attribute: .top, relatedBy: .equal, toItem: titleLabel,
            attribute: .bottom, multiplier: 1.0, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: headerSeparator,
             attribute: .leading, relatedBy: .equal, toItem: titleLabel,
             attribute: .leading, multiplier: 1.0, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: headerSeparator,
            attribute: .trailing, relatedBy: .equal, toItem: titleLabel,
            attribute: .trailing, multiplier: 1.0, constant: 0))
        
        //buttons
        containerView.addConstraint(NSLayoutConstraint(item: containerView,
            attribute: .trailing, relatedBy: .equal, toItem: doneButton,
            attribute: .trailing, multiplier: 1.0, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: containerView,
            attribute: .bottom, relatedBy: .equal, toItem: doneButton,
            attribute: .bottom, multiplier: 1.0, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: doneButton,
            attribute: .width, relatedBy: .equal, toItem: containerView,
            attribute: .width, multiplier: 0.5, constant: 0))
        doneButton.addConstraint(NSLayoutConstraint(item: doneButton,
            attribute: .height, relatedBy: .equal, toItem: nil,
            attribute: .height, multiplier: 1.0, constant: 50))
        
        containerView.addConstraint(NSLayoutConstraint(item: containerView,
            attribute: .leading, relatedBy: .equal, toItem: closeButton,
            attribute: .leading, multiplier: 1.0, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: containerView,
            attribute: .bottom, relatedBy: .equal, toItem: closeButton,
            attribute: .bottom, multiplier: 1.0, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: closeButton,
            attribute: .width, relatedBy: .equal, toItem: containerView,
            attribute: .width, multiplier: 0.5, constant: 0))
        closeButton.addConstraint(NSLayoutConstraint(item: closeButton,
            attribute: .height, relatedBy: .equal, toItem: nil,
            attribute: .height, multiplier: 1.0, constant: 50))
        
        //tableView
        containerView.addConstraint(NSLayoutConstraint(item: containerView,
            attribute: .trailing, relatedBy: .equal, toItem: tableView,
            attribute: .trailing, multiplier: 1.0, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: containerView,
            attribute: .leading, relatedBy: .equal, toItem: tableView,
            attribute: .leading, multiplier: 1.0, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: headerSeparator,
            attribute: .bottom, relatedBy: .equal, toItem: tableView,
            attribute: .top, multiplier: 1.0, constant: 0))
        containerView.addConstraint(NSLayoutConstraint(item: closeButton,
            attribute: .top, relatedBy: .equal, toItem: tableView,
            attribute: .bottom, multiplier: 1.0, constant: 0))
    }
    
    fileprivate func updateUI() {
        self.containerView?.backgroundColor = UIColor.white
        self.containerView?.layer.cornerRadius = self.theme.cornerRadius
        self.containerView?.clipsToBounds = true
        self.titleLabel?.text = "Select"
        self.doneButton?.setTitle("Done", for: .normal)
        self.closeButton?.setTitle("Close", for: .normal)
        
        self.doneButton?.titleLabel?.textAlignment = .center
        self.closeButton?.titleLabel?.textAlignment = .center
        self.titleLabel?.textAlignment = .center
        
        self.titleLabel?.textColor = self.theme.titleColor
        self.doneButton?.setTitleColor(self.theme.doneTextColor, for: .normal)
        self.closeButton?.setTitleColor(self.theme.closeTextColor, for: .normal)
        
        self.titleLabel?.text = self.title
        self.doneButton?.setTitle(self.theme.doneText, for: .normal)
        self.closeButton?.setTitle(self.theme.closeText, for: .normal)
        
        self.titleLabel?.backgroundColor = self.theme.headerBackgroundColor
        self.doneButton?.backgroundColor = self.theme.doneBackgroundColor
        self.closeButton?.backgroundColor = self.theme.closeBackgroundColor
        self.headerSeparator?.backgroundColor = self.theme.separatorColor
        
        self.titleLabel?.font = self.theme.titleFont
        self.doneButton?.titleLabel?.font = self.theme.buttonsFont
        self.closeButton?.titleLabel?.font = self.theme.buttonsFont
        
        self.tableView?.separatorInset = UIEdgeInsets(
            top: 0, left: 0, bottom: 0, right: 0)
        self.tableView?.rowHeight = self.theme.rowHeight
        self.tableView?.separatorStyle = .none
        self.tableView?.tintColor = .clear
        self.tableView?.backgroundColor = self.theme.backgroundColor
        self.containerView?.backgroundColor = self.theme.backgroundColor
        self.headerHC?.constant = self.theme.headerHeight
    }
}
