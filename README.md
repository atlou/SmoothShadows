# SmoothShadows

SmoothShadows is a SwiftUI package that lets you add customizable, smooth shadows to your views.

## Preview

<img src="https://github.com/user-attachments/assets/c053acdf-ce23-48c8-8af8-cc8150c208be" alt="Preview Image" height="300">

## Usage

Import the package in your SwiftUI file:
```
import SmoothShadows
```

Apply the `smoothShadow` modifier to a view:
```swift
Rectangle()
  .smoothShadow(color: .black.opacity(0.5), y: 10)
```

## Installation

Swift Package Manager

1.	Open your Xcode project.
2.	Navigate to `File` > `Add Package Dependencies...`.
3.	Enter the repository URL: `https://github.com/atlou/SmoothShadows/`.
4.	Select “Add Package” to integrate SmoothShadows into your project.

## License

This package is available under the MIT license. See the LICENSE file for more information.
