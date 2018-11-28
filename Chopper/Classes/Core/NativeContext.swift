//
//  NativeContext.swift
//  Chopper
//
//  Created by 王健伟 on 2018/11/28.
//

import WebKit

public final class NativeContext: NSObject {
    public let webView: WKWebView
    public let viewController: UIViewController
    public let frameViewController: UIViewController
    public init(webView: WKWebView, viewController: UIViewController, frameViewController: UIViewController) {
        self.webView = webView
        self.viewController = viewController
        self.frameViewController = frameViewController
    }
}

public extension JavaScriptBridgeDataSource {
    var context: NativeContext {
        return NativeContext(webView: webView, viewController: viewController, frameViewController: frameViewController)
    }
}
