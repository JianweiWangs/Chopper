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
            "changeColor" : { message, callback in
                print(message)
                let frame = message.context.frameViewController
                frame.view.backgroundColor = .gray
                callback()
            }
        ]
    }

    var module: String {
        return "test"
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

class ViewController: UIViewController  {

    @IBOutlet weak var webview: WKWebView!

    var jsbridge: JavaScriptBridge!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webview.load(URLRequest(url: URL(string: "https://www.baidu.com")!))
        webView.uiDelegate = self
        jsbridge = JavaScriptBridge(dataSource: self)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        print("释放了")
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
