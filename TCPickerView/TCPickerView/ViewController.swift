//
//  ViewController.swift
//  TCPickerView
//
//  Created by Taras Chernyshenko on 9/4/17.
//  Copyright © 2017 Taras Chernyshenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction private func showButtonPressed(button: UIButton) {
        let picker = TCPickerView()
        picker.show()
    }
}

