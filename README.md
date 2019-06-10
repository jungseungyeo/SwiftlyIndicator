# SwiftlyIndicator

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg) ![CocoaPods](http://img.shields.io/cocoapods/v/SwiftlyIndicator.svg) ![License](https://img.shields.io/badge/Licence-MIT-green.svg) 

------

## Installation

```ruby
pod init
pod 'SwiftlyIndicator'
pod install

open [project].xcworkspace
```

## Example

```Swift
import SwiftlyIndicator

override func viewDidLoad() {
  // Image Indicator
  view.startImageSwitflyIndicator(images: [UIImage], milliseconds: Int)
}
```
<br />

![](./Images/imageIndicator.gif)

```Swift
import SwiftlyIndicator

override func viewDidLoad() {
  // Image Rotation Indicator
  view.rotationImageSiwftlyIndicator(images: [UIImage], bgColor: UIColor)
}
```
<br />

![](./Images/imageRotation.gif)

```Swift
import SwiftlyIndicator

override func viewDidLoad() {
  // default
  view.startSwiftlyIndicator()
}
```
<br />

![](./Images/defaultIndicator.gif)

```Swift
import SwiftlyIndicator

override func viewDidLoad() {
  // Rotation
  view.rotationSwiftlyIndicator()
}
```
<br />

![](./Images/defaultRotation.gif)

## Author

[LinSaeng](https://github.com/jungseungyeo)

## License

SwiftlyIndicator is licensed under the MIT license. Check the [LICENSE](LICENSE) file for details.
