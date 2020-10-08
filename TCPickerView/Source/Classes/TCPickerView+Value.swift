//
//  TCPickerView+Value.swift
//  TCPickerView
//
//  Created by Taras Chernyshenko on 10/7/20.
//

import Foundation

public extension TCPickerView {
    struct Value {
        public let title: String
        public var isChecked: Bool
        
        public init(title: String, isChecked: Bool = false) {
            self.title = title
            self.isChecked = isChecked
        }
    }
}
