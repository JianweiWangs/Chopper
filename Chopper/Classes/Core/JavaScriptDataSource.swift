//
//  JavaScriptDataSource.swift
//  Chopper
//
//  Created by 王健伟 on 2018/11/27.
//

import WebKit

public protocol JavaScriptBridgeDataSource: class {
    var webView: WKWebView { get }
    var modules: [JavaScriptModuleInterface] { get }
    var viewController: UIViewController { get }
    var frameViewController: UIViewController { get }
}

public extension JavaScriptBridgeDataSource {
    var modules: [JavaScriptModuleInterface] {
        return []
    }
    var frameViewController: UIViewController {
        return viewController
    }
}


