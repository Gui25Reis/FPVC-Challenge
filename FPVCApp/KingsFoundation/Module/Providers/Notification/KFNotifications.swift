//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

public struct KFNotificator {
    
    public let provider: KFNotificationType
    
    
    public init(provider: KFNotificationType) {
        self.provider = provider
    }
    
    
    public func register(_ observer: Any, action: Selector, key: KFNotificationKeys, object: Any? = nil) {
        provider.addObserver(observer, selector: action, name: key.name, object: object)
    }
    
    public func unregister(_ observer: Any, key: KFNotificationKeys, object: Any? = nil) {
        provider.removeObserver(observer, name: key.name, object: object)
    }
    
    public func sendEvent(forKey key: KFNotificationKeys, object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        print("[KFNotificator] Enviando evento -> \(key)")
        provider.post(name: key.name, object: object, userInfo: userInfo)
    }
}
