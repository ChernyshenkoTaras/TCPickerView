//
//  TCPickerViewDarkTheme.swift
//  TCPickerView
//
//  Created by Taras Chernyshenko on 6/13/18.
//

import UIKit

public final class TCPickerViewDarkTheme: TCPickerViewThemeType {
    
    public let mainColor: UIColor = UIColor(red: 47/255, green: 56/255, blue: 65/255, alpha: 1)
    public let textColor: UIColor = UIColor(red: 115/255, green: 124/255, blue: 129/255, alpha: 1)
    
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
        return self.textColor
    }
    
    public var buttonsFont: UIFont {
        return UIFont.systemFont(ofSize: 16)
    }
    
    public var titleFont: UIFont{
        return UIFont.boldSystemFont(ofSize: 18)
    }
    
    public var rowHeight: CGFloat {
        return 50
    }
    
    public var cornerRadius: CGFloat {
        return 8.0
    }
    
    public required init() {}
}
