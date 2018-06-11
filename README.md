# TCPickerView
Picker view popup with multiply rows selection written in Swift. 

<a href="https://imgflip.com/gif/2c0eb5"><img src="https://i.imgflip.com/2c0eb5.gif" title="example"/></a>
<a href="https://imgflip.com/gif/2c0esf"><img src="https://i.imgflip.com/2c0esf.gif" title="made at imgflip.com"/></a>

## Requirements

TimeIntervalPicker works on iOS 9 and higher. It depends on the following Apple frameworks, which should already be included with most Xcode templates:

* Foundation
* UIKit

## Installation
#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `TimeIntervalPicker` by adding it to your `Podfile`:

```ruby
platform :ios, '9.0'
use_frameworks!
pod 'TCPickerView'
```
#### Manually
1. Download and drop ```Classes``` and ```Assets``` folder in your project.
2. Congratulations!

## Example

```swift
import UIKit
import TCPickerView

class ViewController: UIViewController {

    @IBAction private func showButtonPressed(button: UIButton) {
        var picker: TCPickerViewInput = TCPickerView()
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
        picker.delegate = self
        picker.selection = .single
        picker.itemsFont = UIFont.systemFont(ofSize: 15, weight: .bold)
        picker.completion = { (selectedIndexes) in
            for i in selectedIndexes {
                print(values[i].title)
            }
        }
        picker.show()
    }
}
```

If you want to set pre-selected values: `TCPickerView.Value(title: "Chevrolet Bolt EV", isChecked: true)`

Picker supports `multiply`, `single` and `none` row selection. You can set desired behavior by setting `selection` property of `TCPickerView` to the appropriate value.

#### Tracking user actions

`TCPickerViewOutput` allows you track what item was selected. Implament this method in your controller and assign `delegate` property 
to this controller.

```swift
public protocol TCPickerViewOutput: class {
    func pickerView(_ pickerView: TCPickerView, didSelectRowAtIndex index: Int)
}
```

You can request new method if you need it. I'm open to discuss

#### UI customization
Use `TCPickerViewInput` protocol for change appearance :

```swift
    var title: String { set get } // default is 'Select'
    var doneText: String { set get } // default is 'Done'
    var closeText: String { set get } // default is 'Close'
    var textColor: UIColor { set get } // change text color of title, done and close buttons
    var mainColor: UIColor { set get } // change topBar and Done button backgroundColor
    var closeButtonColor: UIColor { set get } // change bacground color of Close button
    var buttonFont: UIFont { set get } // set close and done buttons font
    var titleFont: UIFont { set get } // default is 
    var itemsFont: UIFont { set get } // default cells item title font
    var rowHeight: CGFloat { set get } // default is 50
    var cornerRadius: CGFloat { set get } //default is 15.0
    var background: UIColor { set get } // default is .white
```

#### Use your own cells

* desing your cell in .xib or code
* conform your cell to `TCPickerCellType` protocol
* register cell in picker by using one of next methods
```swift
    func register(_ nib: UINib?, forCellReuseIdentifier identifier: String)
    func register(_ cellClass: Swift.AnyClass?, forCellReuseIdentifier identifier: String)
```
* implement `TCPickerViewOutput` protocol in your view controller
* dequeue your cell in `func pickerView(_ pickerView: TCPickerViewInput,
        cellForRowAt indexPath: IndexPath) -> (UITableViewCell & TCPickerCellType)?` method by calling `func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell & TCPickerCellType`
* for more details have a look into `CustomCellViewController` in example project

## Contributing to this project

If you have feature requests or bug reports, feel free to help out by sending pull requests or create issues.

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
