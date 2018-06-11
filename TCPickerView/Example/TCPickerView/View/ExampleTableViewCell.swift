//
//  ExampleTableViewCell.swift
//  TCPickerViewExample
//
//  Created by Taras Chernyshenko on 6/11/18.
//  Copyright © 2018 Taras Chernyshenko. All rights reserved.
//

import UIKit
import TCPickerView

class ExampleTableViewCell: UITableViewCell, TCPickerCellType {
    var viewModel: TCPickerModel? {
        didSet {
            self.updateUI()
        }
    }
    
    @IBOutlet private weak var titleLabel: UILabel?
    @IBOutlet private weak var checkmarkView: UIView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.checkmarkView?.layer.cornerRadius = 8.0
        self.backgroundColor = .black
        self.titleLabel?.textColor = .white
        self.tintColor = .clear
        self.selectionStyle = .none
    }
    
    func updateUI() {
        guard let viewModel = self.viewModel else {
            return
        }
        self.titleLabel?.text = viewModel.title
        self.checkmarkView?.backgroundColor = viewModel.isChecked ? .white : .clear
    }
}
