# EnvSwitcher

[![CI Status](http://img.shields.io/travis/kana_app/EnvSwitcher.svg?style=flat)](https://travis-ci.org/kana_app/EnvSwitcher)
[![Version](https://img.shields.io/cocoapods/v/EnvSwitcher.svg?style=flat)](http://cocoapods.org/pods/EnvSwitcher)
[![License](https://img.shields.io/cocoapods/l/EnvSwitcher.svg?style=flat)](http://cocoapods.org/pods/EnvSwitcher)
[![Platform](https://img.shields.io/cocoapods/p/EnvSwitcher.svg?style=flat)](http://cocoapods.org/pods/EnvSwitcher)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

EnvSwitcher is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EnvSwitcher', :git => 'https://github.com/keyfun/EnvSwitcher.git'
```

## How to Use? Initial in AppDelegate as below

```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    // Override point for customization after application launch.

    // get previous selection
    let env = EnvSwitcher.getUserPreferences()
    print("env = \(env)")
    
    // init the long press gesture and options
    let duration:Double = 3.0
    let options:[String] = ["Production", "UAT", "Staging", "Development"]
    EnvSwitcher.initSwitcher(window, duration: duration, options: options, isSave: true) { (option:String) -> Void in
        print("onSelected Option = \(option)")
        self.window?.rootViewController = ViewController()
    }
    
    return true
}
```

## Author

keyfun, keyfun.hk@gmail.com

## License

EnvSwitcher is available under the MIT license. See the LICENSE file for more info.
