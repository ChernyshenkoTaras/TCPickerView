//
//  LightViewController.swift
//  TCPickerViewExample
//
//  Created by Taras Chernyshenko on 6/13/18.
//  Copyright © 2018 Taras Chernyshenko. All rights reserved.
//

import UIKit
import TCPickerView

class LightViewController: UIViewController, TCPickerViewOutput {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    private let theme = TCPickerViewLightTheme()
    @IBAction private func showButtonPressed(button: UIButton) {
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let width: CGFloat = screenWidth - 64
        let height: CGFloat = 500
        var picker: TCPickerViewInput = TCPickerView(size: CGSize(width: width, height: height))
        picker.title = "Cars"
        let cars = [
            "Chevrolet Bolt EV",
            "Subaru WRX",
            "Porsche Panamera",
            "BMW 330e",
            "Chevrolet Volt",
            "Ford C-Max Hybrid",
            "Ford Focus"
        ]
        let values = cars.map { TCPickerView.Value(title: $0) }
        picker.values = values
        picker.theme = self.theme
        picker.delegate = self
        picker.selection = .multiply
        picker.registerCell(UINib(nibName: "ExampleTableViewCell", bundle: nil), forCellReuseIdentifier: "ExampleTableViewCell")
        picker.completion = { (selectedIndexes) in
            for i in selectedIndexes {
                print(values[i].title)
            }
        }
        picker.show()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    //MARK: TCPickerViewDelegate methods
    
    func pickerView(_ pickerView: TCPickerViewInput, didSelectRowAtIndex index: Int) {
        print("Uuser select row at index: \(index)")
    }
    
    func pickerView(_ pickerView: TCPickerViewInput,
                    cellForRowAt indexPath: IndexPath) -> (UITableViewCell & TCPickerCellType)? {
        let cell = pickerView.dequeueCell(withIdentifier: "ExampleTableViewCell", for: indexPath) as! ExampleTableViewCell
        cell.titleLabel?.textColor = self.theme.textColor
        cell.checkmarkImageView?.image = UIImage(named: "checkmark_icon")?.withRenderingMode(.alwaysTemplate)
        cell.checkmarkImageView?.tintColor = self.theme.textColor
        cell.backgroundColor = self.theme.mainColor
        return cell
    }
}
