# CGMessageTextView

A UITextView subclass that adds support for changing dinamically the height in base of the text.
Also it has multiline placeholder thansk to https://github.com/MoZhouqi/KMPlaceholderTextView.
All is written in Swift and it use AutoLayout.

## Usage

You can set one of the following values:
```swift
placeholderText
placeholderTextColor
placeholderFont
placeholderTextAlignment
```

In order to change dinamically the heigh, use one of the follow delegates:
```swift
func contentSizeDidChange(withContentSize contentSize: CGSize)
func contentSizeWidthDidChange(withWidth width: CGFloat)
func contentSizeDeltaWidthDidChange(withDelta delta: CGFloat)
func contentSizeHeightDidChange(withHeight height: CGFloat)
func contentSizeDeltaHeightDidChange(withDelta delta: CGFloat)
```

### Code

Initialization
```swift
let messageTextView = CGMessageTextView()
messageTextView.messageTextViewDelegate = self
messageTextView.placeholderText = "Write something..."
addSubview(messageTextView)
```

Delegates ( all are optional )
```swift
extension MyClass: CGMessageTextViewDelegate {
func contentSizeDidChange(withContentSize contentSize: CGSize) { }
func contentSizeWidthDidChange(withWidth width: CGFloat) { }
func contentSizeDeltaWidthDidChange(withDelta delta: CGFloat) { }
func contentSizeHeightDidChange(withHeight height: CGFloat) { }
func contentSizeDeltaHeightDidChange(withDelta delta: CGFloat) { }
}
```

## Installation

### CocoaPods

You can install the latest release version of CocoaPods with the following command:

```bash
$ gem install cocoapods
```

Simply add the following line to your Podfile:

```ruby
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
pod 'CGMessageTextView', '~> 1.0.0'
end
```

Then, run the following command:

```bash
$ pod install
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate CGMessageTextView into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "cikpis/CGMessageTextView" ~> 1.0.0
```

## Requirements

- iOS 7.0+
- Xcode 8.0+
- Swift 3.0+

## License

CGMessageTextView is released under the MIT license. See LICENSE for details.
