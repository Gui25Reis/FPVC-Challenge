//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import Security
import KingsFoundation


final public class KeychainManager: StorageHadler {
    
    public typealias StorageData = String
    

    public init() {
        /* Permitindo instância da classe */
    }
    
    
    public func save(_ data: StorageData, forKey key: String) {
        if let _ = retrieve(forKey: key) { return }
        
        guard var valueData = data.data(using: .utf8)
        else { return }
        
        var dict = KeychainDict()
        dict.add(parameter: .key(key))
        dict.add(parameter: .value(valueData))
        
        valueData = Data()
        _ = SecItemAdd(dict.query, nil)
    }
    
    public func retrieve(forKey key: String) -> StorageData? {
        var dict = KeychainDict()
        dict.add(parameter: .key(key))
        dict.add(parameter: .needsReturnData)
        dict.add(parameter: .limitOne)
        
        var result: AnyObject?
        let status = SecItemCopyMatching(dict.query, &result)
        
        let isSuccess = status == errSecSuccess
        let data = result as? Data
        
        if var data, isSuccess {
            defer { data = Data() }
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    public func delete(forKey key: String) {
        var dict = KeychainDict()
        dict.add(parameter: .key(key))
        
        _ = SecItemDelete(dict.query)
    }
    
    public func cleanAll() {
        let dict = KeychainDict()
        _ = SecItemDelete(dict.query)
    }
}
