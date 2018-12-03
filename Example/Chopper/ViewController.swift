//
//  ViewController.swift
//  Chopper
//
//  Created by JianweiWangs on 11/20/2018.
//  Copyright (c) 2018 JianweiWangs. All rights reserved.
//

import UIKit
import WebKit
import Chopper

extension ViewController: JavaScriptModuleInterface {
    var moduleMapping: [String : Dispatch] {
        return [
            "showAlert" : { message, callback in
                print(message.params)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    callback(false, ["reason":"GG"])
                })
            }
        ]
    }
    var module: String {
        return "test"
    }
}

class ViewController: UIViewController  {

    @IBOutlet weak var webview: WKWebView!

    var jsbridge: JavaScriptBridge!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webview.load(URLRequest(url: URL(string: "https://www.baidu.com")!))
        webView.uiDelegate = self
        jsbridge = JavaScriptBridge(dataSource: self)
        do {
            let script = try String(contentsOf: URL(string: "https://npm-cdn.herokuapp.com/@jianweiwangs/chopper@1.0.0/index.js")!)
            webView.configuration.userContentController.addUserScript(
                WKUserScript(
                    source: script,
                    injectionTime: .atDocumentStart,
                    forMainFrameOnly: true
                )
            )
        } catch let e {
            print(e)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.webView.evaluateJavaScript(
                """
dispatch('test', 'showAlert', {
  'title': 'Chopper',
  'message': '这是一次 js call native 的测试'
}, function (success, params) {
  alert('callback isSuccess: ' + success + ' params: ' + params.reason)
})
""",
                completionHandler: nil
            )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        print("释放了")
    }
}


extension ViewController : JavaScriptBridgeDataSource {

    var viewController: UIViewController {
        return self
    }

    var webView: WKWebView {
        return self.webview
    }

    var modules: [JavaScriptModuleInterface] {
        return [self]
    }

}

extension ViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: webView.title, message: message, preferredStyle: .alert)
        let sureAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alert.addAction(sureAction)
        present(alert, animated: true, completion: completionHandler)
    }
}
