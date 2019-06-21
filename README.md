# SwiftlyIndicator

![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg) ![CocoaPods](http://img.shields.io/cocoapods/v/SwiftlyIndicator.svg) ![License](https://img.shields.io/badge/Licence-MIT-green.svg)

------

## Installation

```ruby
pod 'SwiftlyIndicator'
```

## Example

```Swift
import SwiftlyIndicator

override func viewDidLoad() {

  // Setting SwiftlyIndicator type -- default type basic
  view.setupSwiftlyIndicator(type: SwiftlyIndicatorType)

  // Start SwiftlyIndicator
  view.startWaiting()

  // Stop SwiftlyIndicator
  view.stopWaiting()

}
```

```Swift

// SwiftlyIndicator type
public enum SwiftlyIndicatorType: Equatable {
    case basic
    case rotationBasic
    case circleBasic
    case image(images: [UIImage], chagedMilliseconds: Int)
    case rotationImage(images: [UIImage])
}
```
<br />

```
type image
```

<br />

<img src="/Images/imageIndicator.gif" alt="screenshot" width="auto" height="500" />

<br />

```
type rotationImage
```
<br />

<img src="/Images/imageRotation.gif" alt="screenshot" width="auto" height="500" />

<br />

```
type basic
```

<br />

<img src="/Images/defaultIndicator.gif" alt="screenshot" width="auto" height="500" />

<br />

```
type rotationBasic
```

<br />

<img src="/Images/defaultRotation.gif" alt="screenshot" width="auto" height="500" />

## Author

[LinSaeng](https://github.com/jungseungyeo)

## License

SwiftlyIndicator is licensed under the MIT license. Check the [LICENSE](/SwiftlyIndicator/LICENSE) file for details.
