//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

protocol KingsCryptorManager {
    
    func encrypt(data: String, type: KingsCryptorType) throws -> String
}


struct KingsCryptor: KingsCryptorManager {
    
    func encrypt(data: String, type: KingsCryptorType) throws -> String {
        let handler = type.handler
        
        let encryptedData = handler.encrypt(data: data)
        return encryptedData
    }
}
