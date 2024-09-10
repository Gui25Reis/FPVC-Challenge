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
    
    let storage: any StorageHadler
    
    init(storage: any StorageHadler) {
        self.storage = storage
    }
    
    
    func saveAPIInfos() {
        let storage = KeychainManager()
        storage.cleanAll()
        storage.save("c5708bd6e9d89b845048ebc1d0e78a9872594cd8", forKey: "marvelPriv")
        storage.save("124db90affdebfdb6cbd55a90ffcb4fd", forKey: "marvelPublic")
        
        print(storage.retrieve(forKey: "marvelPublic") as Any)
        print(storage.retrieve(forKey: "marvelPriv") as Any)
    }
}
