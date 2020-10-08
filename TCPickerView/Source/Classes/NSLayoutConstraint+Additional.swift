//
//  NSLayoutConstraint+Additional.swift
//  TCPickerView
//
//  Created by Taras Chernyshenko on 10/8/20.
//

import UIKit

public enum ConstraintIdentifier: String {
    case leading, trailing, top, bottom, height, width
}

public extension NSLayoutDimension {
    func constraint(equalToConstant c: CGFloat, identifier: ConstraintIdentifier) -> NSLayoutConstraint {
        let constraint = self.constraint(equalToConstant: c)
        constraint.identifier = identifier.rawValue
        return constraint
    }
}

public extension UIView {
    func constraint(withIdentifier: ConstraintIdentifier) -> NSLayoutConstraint? {
        return self.constraints.filter{ $0.identifier == withIdentifier.rawValue }.first
    }
}
