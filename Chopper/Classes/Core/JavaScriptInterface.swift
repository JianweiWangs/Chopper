//
//  JavaScriptInterface.swift
//  Chopper
//
//  Created by 王健伟 on 2018/11/27.
//

public protocol JavaScriptModuleInterface: class {
    var moduleMapping: [String : Dispatch] { get }
    var module: String { get }
    var actions: [String] { get }
    func moduleDidLoad()
    func canLoadAtVersion(version: String) -> Bool
}

public extension JavaScriptModuleInterface {
    var actions: [String] {
        return Array(moduleMapping.keys)
    }
    func moduleDidLoad() {
        // override
    }
    func canLoadAtVersion(version: String) -> Bool {
        // default true
        return true
    }
}

public extension JavaScriptModuleInterface {
    func handle(message: JavaScriptMessage, target: JavaScriptBridgeDataSource) {
        guard let nativeAction = moduleMapping[message.action] else {
            return
        }
        message.context = target.context
        nativeAction(message, {
            target.webView.evaluateJavaScript("alert(\"调用成功\")", completionHandler: nil)
        })
    }
    func send(message: JavaScriptMessage, target: JavaScriptBridgeDataSource) {
        target.webView.evaluateJavaScript(message.dispathScript) { (_, _) in
            
        }
    }
}
