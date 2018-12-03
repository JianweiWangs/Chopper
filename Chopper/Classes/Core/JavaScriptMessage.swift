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

//    public func encode(to encoder: Encoder) throws {
////        let values =
//    }
//    public init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        module = try values.decode(String.self, forKey: .module)
//        action = try values.decode(String.self, forKey: .action)
//        callbackID = try values.decode(String.self, forKey: .callbackID)
//        params = (try? values.decode([String : AnyDecodable].self, forKey: .params))
//    }
}


extension JavaScriptMessage: CustomStringConvertible {
    public var description: String {
        return
"""
----JavaScriptMessage----
| module : \(module)
| action : \(action)
| callbackID : \(callbackID)
| params : \(String(describing: params))
----JavaScriptMessage----
"""
    }
}

extension JavaScriptMessage: JavaScriptFunction { }
