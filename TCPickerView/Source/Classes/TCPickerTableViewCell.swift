//
//  TCPickerTableViewCell.swift
//  TCPickerView
//
//  Created by Taras Chernyshenko on 9/4/17.
//  Copyright © 2017 Taras Chernyshenko. All rights reserved.
//

import UIKit

class TCPickerTableViewCell: UITableViewCell {
    
    struct ViewModel {
        let title: String
        let isChecked: Bool
    }
    
    var viewModel: ViewModel? {
        didSet {
            self.titleLabel?.text = self.viewModel?.title ?? ""
            self.checkmarkImageView?.image = self.viewModel?.isChecked == true ?
                self.checkmark : UIImage()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel?.text = self.viewModel?.title ?? ""
        self.checkmarkImageView?.image = self.viewModel?.isChecked == true ?
            self.checkmark : UIImage()
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
    private var titleLabel: UILabel?
    private var checkmarkImageView: UIImageView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    fileprivate func initialize() {
        self.titleLabel = UILabel(frame: CGRect.zero)
        self.checkmarkImageView = UIImageView(frame: CGRect.zero)
        self.checkmarkImageView?.contentMode = .scaleAspectFit
        self.setupUI()
    }
    
    fileprivate func setupUI() {
        guard let titleLabel = self.titleLabel,
            let imageView = self.checkmarkImageView else {
                return
        }
        
        self.addSubview(titleLabel)
        self.addSubview(imageView)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.addConstraint(NSLayoutConstraint(item: imageView,
            attribute: .height, relatedBy: .equal, toItem: nil,
            attribute: .height, multiplier: 1.0, constant: 24))
        imageView.addConstraint(NSLayoutConstraint(item: imageView,
            attribute: .width, relatedBy: .equal, toItem: nil,
            attribute: .width, multiplier: 1.0, constant: 24))
        self.addConstraint(NSLayoutConstraint(item: self,
            attribute: .trailing, relatedBy: .equal, toItem: imageView,
            attribute: .trailing, multiplier: 1.0, constant: 8))
        self.addConstraint(NSLayoutConstraint(item: imageView,
            attribute: .centerY, relatedBy: .equal, toItem: self,
            attribute: .centerY, multiplier: 1.0, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: titleLabel,
            attribute: .leading, relatedBy: .equal, toItem: self,
            attribute: .leading, multiplier: 1.0, constant: 8))
        self.addConstraint(NSLayoutConstraint(item: titleLabel,
            attribute: .top, relatedBy: .equal, toItem: self,
            attribute: .top, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: titleLabel,
            attribute: .bottom, relatedBy: .equal, toItem: self,
            attribute: .bottom, multiplier: 1.0, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: titleLabel,
            attribute: .trailing, relatedBy: .equal, toItem: imageView,
            attribute: .leading, multiplier: 1.0, constant: 8))
    }
}
