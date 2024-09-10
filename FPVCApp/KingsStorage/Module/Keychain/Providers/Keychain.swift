//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import UIKit


public struct Keychain: KeychainProvider {
    
    public init() {
        
    }
    
    
    @discardableResult
    public func create(_ data: CFDictionary) -> Bool {
        SecItemAdd(data, nil) == errSecSuccess
    }
    
    @discardableResult
    public func read(_ data: CFDictionary, result: inout AnyObject?) -> Bool {
        SecItemCopyMatching(data, &result) == errSecSuccess
    }
    
    @discardableResult
    public func delete(_ data: CFDictionary) -> Bool {
        SecItemDelete(data) == errSecSuccess
    }
}
