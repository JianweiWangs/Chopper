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

//MARK: Chopper

extension ViewController : JavaScriptBridgeDataSource {

    // 这里是当前控制器意图使用哪些模块的交互方法，比如这里有 test，以后可能会有诸如 base net ui pay 等 js 交互

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

class ViewController: UIViewController  {

    @IBOutlet weak var webview: WKWebView!

    var jsbridge: JavaScriptBridge!

    override func viewDidLoad() {
        super.viewDidLoad()

        jsbridge = JavaScriptBridge(dataSource: self)

        setupWebView()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.evaluateJavaScript(script: showAlert)
        }
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
