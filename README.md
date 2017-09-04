# TCPickerView
Picker view popup with multiply rows selection written in Swift. 

![](https://github.com/ChernyshenkoTaras/TCPickerView/blob/master/TCPickerView/TCPickerView/Images/PickerView_1.gif?raw=true)

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
        picker.completion = { (selectedIndexes) in
            for i in selectedIndexes {
                print(values[i].title)
            }
        }
        picker.show()
    }
}
```

## License

This code is distributed under the terms and conditions of the [MIT license](LICENSE).
