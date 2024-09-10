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


public struct CacheManager: StorageHadler {
    
    public typealias StorageData = Any
    
    let storage: UserDefaults
    
    public init() {
        self.storage = UserDefaults.standard
    }
    
    public init(storage: UserDefaults) {
        self.storage = storage
    }
    
    public func save(_ data: StorageData, forKey key: String) {
        storage.setValue(data, forKey: key)
    }
    
    public func retrieve(forKey key: String) -> StorageData? {
        storage.object(forKey: key)
    }
    
    public func delete(forKey key: String) {
        storage.removeObject(forKey: key)
    }
    
    public func cleanAll() {
        /* Sem Ação */
    }
}
