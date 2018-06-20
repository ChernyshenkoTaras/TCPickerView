//
//  TCPickerViewLightTheme.swift
//  TCPickerView
//
//  Created by Taras Chernyshenko on 6/13/18.
//

import Foundation

public final class TCPickerViewLightTheme: TCPickerViewThemeType {
    
    public let mainColor: UIColor = .white
    public let textColor: UIColor = .darkGray
    
    public var doneText: String {
        return "OK"
    }
    
    public var closeText: String {
        return "CANCEL"
    }
    
    public var backgroundColor: UIColor {
        return self.mainColor
    }
    
    public var titleColor: UIColor {
        return self.textColor
    }
    
    public var doneTextColor: UIColor {
        return self.textColor
    }
    
    public var closeTextColor: UIColor {
        return self.textColor
    }
    
    public var headerBackgroundColor: UIColor {
        return self.mainColor
    }
    
    public var doneBackgroundColor: UIColor {
        return self.mainColor
    }
    
    public var closeBackgroundColor: UIColor {
        return self.mainColor
    }
    
    public var separatorColor: UIColor {
        return .white
    }
    
    public var buttonsFont: UIFont {
        return UIFont.systemFont(ofSize: 15, weight: .medium)
    }
    
    public var titleFont: UIFont{
        return UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    public var rowHeight: CGFloat {
        return 50
    }
    
    public var cornerRadius: CGFloat {
        return 8.0
    }
    
    public required init() {}
}
