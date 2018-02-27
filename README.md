# TCPickerView
Picker view popup with multiply rows selection written in Swift. 

![](https://github.com/ChernyshenkoTaras/TCPickerView/blob/master/TCPickerView/Example/TCPickerView/Images/PickerView_1.gif?raw=true)

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
        let picker = TCPickerView()
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

`TCPickerViewDelegate` allows you track what item was selected. Implament this method in your controller and assign `delegate` property 
to this controller.

```swift
public protocol TCPickerViewDelegate: class {
    func pickerView(_ pickerView: TCPickerView, didSelectRowAtIndex index: Int)
}
```

You can request new method if you need it. I'm open to discuss

#### UI customization
You can use next properties:

```swift
    //Change title
    open var title: String
    //Change Done button text
    open var doneText: String
    //Change Close button text
    open var closeText: String
    //Change text color of title, done and close buttons
    open var textColor: UIColor
    //Change topBar and Done button backgroundColor
    open var mainColor: UIColor
    //Change bacground color of Close button
    open var closeButtonColor: UIColor
    //Set close and done buttons font
    open var buttonFont: UIFont?
    //Set title font
    open var titleFont: UIFont?
    //Set items font
    open var itemsFont: UIFont
```

I will add new properties on request

## Contributing to this project

If you have feature requests or bug reports, feel free to help out by sending pull requests or create issues.

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
