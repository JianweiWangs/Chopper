//
//  JavaScriptMessage.swift
//  Chopper
//
//  Created by 王健伟 on 2018/11/27.
//

public final class JavaScriptMessage: Codable {
    public let module: String
    public let action: String
    public let callbackID: String
    public var params: [String : AnyCodable]?
    public var context: NativeContext!

    private enum CodingKeys: String, CodingKey {
        case module
        case action
        case callbackID
        case params
    }
    
    public init(module: String, action: String) {
        self.module = module
        self.action = action
        self.callbackID = UUID().uuidString
    }
}


extension JavaScriptMessage: CustomStringConvertible {
    public var description: String {
        return
"""
----JavaScriptMessage----
| module : \(module)
| action : \(action)
| callbackID : \(callbackID)
| params : \(String(describing: params?.mapValues { $0.value })))
----JavaScriptMessage----
"""
    }
}

extension JavaScriptMessage: JavaScriptFunction { }
