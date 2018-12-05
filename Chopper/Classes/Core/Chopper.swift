

public typealias Callback = (Bool, [String : Any]) -> Void
public typealias Dispatch = (JavaScriptMessage, @escaping Callback) -> Void

struct Configure {
    static let nativeMessageHandlerName = "chopperNative"
    static let nativeMessageCallbackHandlerName = "chopperNativeCallback"
    static let webMessageHandlerName = "chopperWeb"
    static let webMessageCallbackHandlerName = "chopperWebCallback"
}


