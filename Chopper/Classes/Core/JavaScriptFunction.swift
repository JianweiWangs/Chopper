//
//  JavaScriptFunction.swift
//  Chopper
//
//  Created by 王健伟 on 2018/11/27.
//


public protocol JavaScriptFunction {
    var module: String { get }
    var action: String { get }
    var callbackID: String { get }
    var dispathScript: String { get }
    var params: [String : AnyCodable]? { get }
    func callbackScript(isSuccess: Bool , param: [String : Any?]) -> String
}

public extension JavaScriptFunction {

    func json(with hash: [String : Any?]?) throws -> String {
        let data = try JSONEncoder().encode(AnyCodable(hash))
        let script = String(data: data, encoding: .utf8) ?? ""
        return script
    }

    var dispathScript: String {
        let hash = params?.mapValues { $0.value }
        var jsonString: String?
        do {
            jsonString = try json(with: hash)
        } catch {
            jsonString = ""
        }
        return "window.\(Configure.webMessageHandlerName).dispath(\(jsonString!))"
    }
    func callbackScript(isSuccess: Bool , param: [String : Any?]) -> String {
        let scriptMap: [String: Any?] = [
            "module" : module,
            "action" : action,
            "callbackID" : callbackID,
            "params" : param
        ]
        var script: String?
        do {
            let data = try JSONEncoder().encode(AnyCodable(scriptMap))
            script = String(data: data, encoding: .utf8) ?? ""
        } catch {
            script = ""
        }
        return "window.\(Configure.webMessageCallbackHandlerName).callback(\(isSuccess), \(script!))"
    }
}
