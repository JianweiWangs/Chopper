//
//  JavaScriptBridge.swift
//  Chopper
//
//  Created by 王健伟 on 2018/11/27.
//

import WebKit

public final class JavaScriptBridge: NSObject {
    public weak var dataSource: JavaScriptBridgeDataSource?
    var callbackQueue: [String : () -> Void] = .init()
    public init(dataSource: JavaScriptBridgeDataSource?) {
        super.init()
        self.dataSource = dataSource
        self.dataSource?.webView.configuration.userContentController.add(self, name: Configure.nativeMessageHandlerName)
        self.dataSource?.webView.configuration.userContentController.add(self, name: Configure.nativeMessageCallbackHandlerName)
    }
}

extension JavaScriptBridge {
    func module(with message: JavaScriptMessage) -> JavaScriptModuleInterface? {
        return dataSource?.modules.first(where: { $0.module == message.module })
    }

    func perform(hybrid message: JavaScriptMessage) {
        guard let module = module(with: message) else {
            return
        }
        guard let dataSource = dataSource else {
            return
        }
        module.handle(message: message, target: dataSource)
    }
    func send(hybrid message: JavaScriptMessage, callbackHandler: (() -> Void)? = nil) {
        guard let module = module(with: message) else {
            return
        }
        if let callback = callbackHandler {
            callbackQueue[message.callbackID] = callback
        }
        guard let dataSource = dataSource else {
            return
        }
        module.send(message: message, target: dataSource)
    }

}

extension JavaScriptBridge: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        do {
            let data = try JSONSerialization.data(withJSONObject: message.body)
            let jsMessage = try JSONDecoder().decode(JavaScriptMessage.self, from: data)
            perform(hybrid: jsMessage)
        } catch {
            //TODO: Exception Handler
        }
    }
}
