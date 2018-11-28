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
    public var params: [String : String]? //TODO: JSON Codable
    public var context: NativeContext!

    enum CodingKeys: String, CodingKey {
        case module
        case action
        case callbackID
        case params
    }

    public init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        module = try values.decode(String.self, forKey: .module)
        action = try values.decode(String.self, forKey: .action)
        callbackID = try values.decode(String.self, forKey: .callbackID)
        params = try? values.decode([String : String].self, forKey: .params)
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
| params : \(String(describing: params))
----JavaScriptMessage----
"""
    }
}

extension JavaScriptMessage: JavaScriptFunction {
    public var parameter: String {
        var scriptMap: [String: AnyHashable] = [
            "module" : module,
            "action" : action,
            "id": callbackID,
        ]
        scriptMap["params"] = params
        var script: String?
        do {
            let data = try JSONSerialization.data(withJSONObject: scriptMap)
            script = String(data: data, encoding: .utf8) ?? ""
        } catch {

        }
        return script!
    }
}
