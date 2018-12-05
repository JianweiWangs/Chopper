# Chopper

[![CI Status](https://img.shields.io/travis/JianweiWangs/Chopper.svg?style=flat)](https://travis-ci.org/JianweiWangs/Chopper)
[![Version](https://img.shields.io/cocoapods/v/Chopper.svg?style=flat)](https://cocoapods.org/pods/Chopper)
[![License](https://img.shields.io/cocoapods/l/Chopper.svg?style=flat)](https://cocoapods.org/pods/Chopper)
[![Platform](https://img.shields.io/cocoapods/p/Chopper.svg?style=flat)](https://cocoapods.org/pods/Chopper)

## Example

use 
```
git clone https://github.com/JianweiWangs/Chopper.git
cd Chopper
make
```
to fetch and build source code quickly.

To run the example project, clone the repo, and run `make` from the root directory first.

There are some script help you develop and PR.

```make
# install dependence and open project
make

# install dependence
make install

# build test
make test

# open project
make open

# quit Xcode
make quit

```

Before you pull request, make sure test success.

## Usage

### Quick Start

#### recommand

1. create a javascript module
```swift
import Chopper
class TestModule: JavaScriptModuleInterface {

    // test module
    var module: String {
        return "test"
    }
    // actions, you can add any action you want
    var moduleMapping: [String : Dispatch] {
        return [
            "showAlert" : showAlert
        ]
    }

    func showAlert(message: JavaScriptMessage, callback: @escaping (Bool, [String : Any]) -> Void) {
        print(message.context.frameViewController)
        print(message.context.viewController)
        print(message)
        callback(true, ["code" : "0"])
    }
}
```
2. create bridge, inject module to dataSource

```swift
import Chopper
class ViewController: UIViewController  {

    @IBOutlet weak var webview: WKWebView!

    var jsbridge: JavaScriptBridge!

    override func viewDidLoad() {
        super.viewDidLoad()

        jsbridge = JavaScriptBridge(dataSource: self)

    }
}

extension ViewController: JavaScriptBridgeDataSource {

    // you can return multiple module instance, the modules more there are, the more actions can be handle
    var modules: [JavaScriptModuleInterface] {
        return [TestModule()]
    }

    var viewController: UIViewController {
        return self
    }

    var webView: WKWebView {
        return self.webview
    }

}
```
3. JavaScript call
```javascript
dispatch('test', 'showAlert', {
  'title': 'Chopper',
  'message': 'this is a js call native test'
}, function (success, params) {
  alert('callback isSuccess: ' + success + ' params: ' + params.code)
})

```

## Requirements

`Swift 4.0`, `iOS 8.0`

## Installation

Chopper is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Chopper'
```

## Author

JianweiWangs, wangfei@zhihu.com

## License

Chopper is available under the MIT license. See the LICENSE file for more info.
