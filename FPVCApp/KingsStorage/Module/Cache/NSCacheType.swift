//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import Foundation


public struct NSCacheType<CacheValue: AnyObject>: StorageHadler {
    
    public typealias StorageData = CacheValue
    
    var cache = NSCache<NSString, CacheValue>()
    
    
    public init() {
        /* Permitindo instância */
    }
    
    public func save(_ data: StorageData, forKey key: String) {
        cache.setObject(data, forKey: key as NSString)
    }
    
    public func retrieve(forKey key: String) -> StorageData? {
        return cache.object(forKey: key as NSString)
    }
    
    public func delete(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    public func cleanAll() {
        cache.removeAllObjects()
    }
}
