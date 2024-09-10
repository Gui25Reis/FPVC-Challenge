//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import KingsStorage


struct MarvelAPIUtils {
    let keychain: KeychainManager
    let cache: CacheManager
    
    var isFirstInstallation = false
    
    
    init(keychain: KeychainManager, cache: CacheManager) {
        self.keychain = keychain
        self.cache = cache
    }
    
    
    mutating func saveAPIInfos() {
        cleanKeychainIfNeeded()
        saveKeysOnKeychainIfNeeded()
    }
    
    private mutating func cleanKeychainIfNeeded() {
        let key: AppCacheKeys = .firstInstallation
        let isFirstInstallation = cache.retrieve(forKey: key.keyName)
        
        guard isFirstInstallation.isNil else { return }
        keychain.cleanAll()
        cache.save(true, forKey: key.keyName)
        self.isFirstInstallation = true
    }
    
    private func saveKeysOnKeychainIfNeeded() {
        guard isFirstInstallation else { return }
        
        let path = Bundle.main.path(forResource: "MarvelInfos", ofType: "plist")
        guard let path else { return }
        
        var dictionary = NSDictionary(contentsOfFile: path) as? [String: Any]
        
        saveOnKeychain(&dictionary, forKey: .marvelPriv)
        saveOnKeychain(&dictionary, forKey: .marvelPubli)
        
        let installationKey: AppCacheKeys = .firstInstallation
        cache.save(true, forKey: installationKey.keyName)
    }

    private func saveOnKeychain(_ dictionary: inout [String: Any]?, forKey key: AppCacheKeys) {
        let data = dictionary?[key.keyName] as? String
        guard let data else { return }
        
        keychain.save(data, forKey: key.keyName)
        dictionary?[key.keyName] = "Blabla"
    }
}
