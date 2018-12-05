
public typealias Dispatch = (JavaScriptMessage, @escaping (Bool, [String : Any]) -> Void) -> Void

struct Configure {
    static let nativeMessageHandlerName = "chopperNative"
    static let nativeMessageCallbackHandlerName = "chopperNativeCallback"
    static let webMessageHandlerName = "chopperWeb"
    static let webMessageCallbackHandlerName = "chopperWebCallback"
}


