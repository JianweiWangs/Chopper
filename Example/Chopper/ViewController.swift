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





//MARK: WKWebView

extension ViewController: WKUIDelegate {

    func setupWebView() {
        webview.load(URLRequest(url: URL(string: "https://www.baidu.com")!))
        webView.uiDelegate = self
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
    }

    func evaluateJavaScript(script: String) {
        self.webView.evaluateJavaScript(
            script,
            completionHandler: nil
        )
    }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: webView.title, message: message, preferredStyle: .alert)
        let sureAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alert.addAction(sureAction)
        present(alert, animated: true, completion: completionHandler)
    }
}
