//
//  TCPickerTableViewCell.swift
//  TCPickerView
//
//  Created by Taras Chernyshenko on 9/4/17.
//  Copyright © 2017 Taras Chernyshenko. All rights reserved.
//

import UIKit

public struct TCPickerModel {
    public let title: String
    public let isChecked: Bool
}

public protocol TCPickerCellType {
    var viewModel: TCPickerModel? { set get }
    func updateUI()
}

class TCPickerTableViewCell: UITableViewCell, TCPickerCellType {

    var viewModel: TCPickerModel? {
        didSet {
            self.updateUI()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateUI()
    }
    
    private var checkmark: UIImage {
        var image = UIImage()
        let podBundle = Bundle(for: TCPickerView.self)
        if let url = podBundle.url(forResource: "TCPickerView", withExtension: "bundle") {
            let bundle = Bundle(url: url)
            image = UIImage(named: "checkmark_icon", in: bundle, compatibleWith: nil)!
        } else {
            return UIImage(named: "checkmark_icon")!
        }
        return image
    }
    private var titleLabel: UILabel = UILabel(frame: CGRect.zero)
    private var checkmarkImageView: UIImageView = UIImageView(frame: CGRect.zero)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }
    
    fileprivate func initialize() {
        self.checkmarkImageView.contentMode = .scaleAspectFit
        self.setupUI()
    }
    
    fileprivate func setupUI() {
        self.addSubview(titleLabel)
        self.addSubview(self.checkmarkImageView)
        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.checkmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.checkmarkImageView.addConstraint(NSLayoutConstraint(item: self.checkmarkImageView,
            attribute: .height, relatedBy: .equal, toItem: nil,
            attribute: .height, multiplier: 1.0, constant: 24))
        self.checkmarkImageView.addConstraint(NSLayoutConstraint(item: self.checkmarkImageView,
            attribute: .width, relatedBy: .equal, toItem: nil,
            attribute: .width, multiplier: 1.0, constant: 24))
        self.addConstraint(NSLayoutConstraint(item: self,
            attribute: .trailing, relatedBy: .equal, toItem: self.checkmarkImageView,
            attribute: .trailing, multiplier: 1.0, constant: 8))
        self.addConstraint(NSLayoutConstraint(item: self.checkmarkImageView,
            attribute: .centerY, relatedBy: .equal, toItem: self,
            attribute: .centerY, multiplier: 1.0, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel,
            attribute: .leading, relatedBy: .equal, toItem: self,
            attribute: .leading, multiplier: 1.0, constant: 8))
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel,
            attribute: .top, relatedBy: .equal, toItem: self,
            attribute: .top, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel,
            attribute: .bottom, relatedBy: .equal, toItem: self,
            attribute: .bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel,
            attribute: .trailing, relatedBy: .equal, toItem: imageView,
            attribute: .leading, multiplier: 1.0, constant: 8))
        self.selectionStyle = .none
    }
    
    func updateUI() {
        self.titleLabel.text = self.viewModel?.title ?? ""
        self.checkmarkImageView.image = self.viewModel?.isChecked == true ?
            self.checkmark : UIImage()
    }
}
