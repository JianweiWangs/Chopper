// https://github.com/Quick/Quick

import Quick
import Nimble
import Chopper

class Module: JavaScriptModuleInterface {

    var moduleMapping: [String : Dispatch] = [
        "showAlert": { message, callback in
            print(message)
            callback(true, ["success":"true"])
        }
    ]

    var module: String = "123"
}

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("xxx") {
            let message = JavaScriptMessage(module: "name", action: "age")
            message.params = [
                "key": 666
            ]
            print(message.dispathScript)
            print(message.callbackScript(isSuccess: true, param: ["name": "wangjianwei"]))
        }
    }
}
