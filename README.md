# SwiftlyIndicator
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)  [![CocoaPods](http://img.shields.io/cocoapods/v/Then.svg)](https://cocoapods.org/pods/SwiftlyIndicator) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

---

## Installation

```ruby
pod 'SwiftlyIndicator'
```

## Example
```Swift
// Image Indicator
view.startImageSwitflyIndicator(images: [UIImage], milliseconds: Int)
```

![](./images/imageIndicator.gif)

```Swift
view.rotationImageSiwftlyIndicator(images: [UIImage], bgColor: UIColor)
```
![](./images/imageRotation.gif)

```Swift
// default
view.startSwiftlyIndicator()
```
![](./images/defaultIndicator.gif)

```Swift
// Rotation
view.rotationSwiftlyIndicator()
```
![](./images/defaultRotation.gif)
