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
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var checkmarkImageView: UIImageView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = .clear
        self.selectionStyle = .none
    }
    
    func updateUI() {
        guard let viewModel = self.viewModel else {
            return
        }
        self.titleLabel?.text = viewModel.title
        self.checkmarkImageView?.isHidden = !viewModel.isChecked
    }
}
