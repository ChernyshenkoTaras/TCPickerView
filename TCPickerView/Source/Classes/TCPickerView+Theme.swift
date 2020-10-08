//
//  TCPickerView+Theme.swift
//  TCPickerView
//
//  Created by Taras Chernyshenko on 10/7/20.
//

import Foundation

extension TCPickerView {
    func change(_ theme: TCPickerViewThemeType) {
        titleLabel.textColor = theme.titleColor
        titleLabel.backgroundColor = theme.headerBackgroundColor
        titleLabel.font = theme.titleFont
        containerView.layer.cornerRadius = theme.cornerRadius
        containerView.backgroundColor = theme.backgroundColor
        tableView.rowHeight = theme.rowHeight
        tableView.backgroundColor = theme.backgroundColor
        doneButton.setTitleColor(theme.doneTextColor, for: .normal)
        doneButton.backgroundColor = theme.doneBackgroundColor
        doneButton.setTitle(theme.doneText, for: .normal)
        doneButton.titleLabel?.font = theme.buttonsFont
        closeButton.setTitleColor(theme.closeTextColor, for: .normal)
        closeButton.backgroundColor = theme.closeBackgroundColor
        closeButton.setTitle(theme.closeText, for: .normal)
        closeButton.titleLabel?.font = theme.buttonsFont
        headerSeparator.backgroundColor = theme.separatorColor
        headerHC.constant = theme.headerHeight
    }
}
