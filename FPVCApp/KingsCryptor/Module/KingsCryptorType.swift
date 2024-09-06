//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

public enum KingsCryptorType {
    case md5
    
    var handler: KingsCryptorHandler {
        return switch self {
        case .md5: MD5Cryptor()
        }
    }
}
