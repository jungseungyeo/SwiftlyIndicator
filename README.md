# SwiftlyIndicator
![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)  [![CocoaPods](http://img.shields.io/cocoapods/v/SwiftlyIndicator.svg)](https://cocoapods.org/pods/SwiftlyIndicator)

---

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
![](./Images/imageIndicator.gif)

```Swift
import SwiftlyIndicator

override func viewDidLoad() {
  // Image Rotation Indicator
  view.rotationImageSiwftlyIndicator(images: [UIImage], bgColor: UIColor)
}
```
![](./Images/imageRotation.gif)

```Swift
import SwiftlyIndicator

override func viewDidLoad() {
  // default
  view.startSwiftlyIndicator()
}
```
![](./Images/defaultIndicator.gif)

```Swift
import SwiftlyIndicator

override func viewDidLoad() {
  // Rotation
  view.rotationSwiftlyIndicator()
}
```
![](./Images/defaultRotation.gif)
