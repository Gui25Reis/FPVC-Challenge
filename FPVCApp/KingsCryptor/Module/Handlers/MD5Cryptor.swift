//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import CryptoKit
import Foundation


struct MD5Cryptor: KingsCryptorHandler {
    
    func encrypt(data: String) -> String {
        let value = Data(data.utf8)
        let digest = Insecure.MD5.hash(data: value)
        
        let encrypted = digest.map { String(format: "%02hhx", $0) }.joined()
        return encrypted
    }
}
