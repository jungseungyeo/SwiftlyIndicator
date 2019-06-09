# SwiftlyIndicator
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)  [![CocoaPods](http://img.shields.io/cocoapods/v/Then.svg)](https://cocoapods.org/pods/SwiftlyIndicator) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

---

## Installation

```ruby
pod 'SwiftlyIndicator'
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
