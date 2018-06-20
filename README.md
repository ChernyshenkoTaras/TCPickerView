# TCPickerView
Picker view popup with multiply rows selection written in Swift. 

<a href="https://imgflip.com/gif/2cl3vt"><img src="https://i.imgflip.com/2cl3vt.gif" title="made at imgflip.com"/></a>
<a href="https://imgflip.com/gif/2cl3l3"><img src="https://i.imgflip.com/2cl3l3.gif" title="made at imgflip.com"/></a>
<a href="https://imgflip.com/gif/2cl3ix"><img src="https://i.imgflip.com/2cl3ix.gif" title="made at imgflip.com"/></a>

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
Create a class that conform to `TCPickerViewThemeType` protocol and adjust UI layout or use one of the existing themes:
* TCPickerViewDefaultTheme
* TCPickerViewLightTheme
* TCPickerViewDarkTheme

Use them as reference for creation you own awesome design.

You can change next properties:

```
var doneText: String { get }
var closeText: String { get }

var backgroundColor: UIColor { get }
var titleColor: UIColor { get }
var doneTextColor: UIColor { get }
var closeTextColor: UIColor { get }
var headerBackgroundColor: UIColor { get }
var doneBackgroundColor: UIColor { get }
var closeBackgroundColor: UIColor { get }
var separatorColor: UIColor { get }

var buttonsFont: UIFont { get }
var titleFont: UIFont { get }

var rowHeight: CGFloat { get }
var headerHeight: CGFloat { get }
var cornerRadius: CGFloat { get }
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
* for more details have a look into `LightViewController` file in a example project.

## Contributing to this project

If you have feature requests or bug reports, feel free to help out by sending pull requests or create issues.

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
