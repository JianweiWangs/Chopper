//
//  JavaScriptFunction.swift
//  Chopper
//
//  Created by 王健伟 on 2018/11/27.
//


public protocol JavaScriptFunction {
    var dispathScript: String { get }
    var callbackScript: String { get }
    var parameter: String { get }
}

public extension JavaScriptFunction {
    var dispathScript: String {
        return "window.\(Configure.webMessageHandlerName).dispath(\(parameter))"
    }
    var callbackScript: String {
        return "window.\(Configure.webMessageCallbackHandlerName).callback(\(parameter))"
    }
}
