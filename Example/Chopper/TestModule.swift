//
//  TestModule.swift
//  Chopper_Example
//
//  Created by 王健伟 on 2018/12/5.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Chopper

// 可以以 module 来进行分组 比如该 module 为 test

class TestModule: JavaScriptModuleInterface {

    var module: String {
        return "test"
    }
    
    var moduleMapping: [String : Dispatch] {
        return [
            "showAlert" : showAlert
        ]
    }

    func showAlert(message: JavaScriptMessage, callback: @escaping (Bool, [String : Any]) -> Void) {
        print(message.context.frameViewController)
        print(message.context.viewController)
        print(message)
        callback(true, ["code" : "0"])
    }
}
