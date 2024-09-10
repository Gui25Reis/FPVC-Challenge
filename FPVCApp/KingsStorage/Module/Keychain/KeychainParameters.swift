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


enum KeychainParameters {
    case key(_ data: String)
    case value(_ data: Data)
    case needsReturnData
    case limitOne
    
    
    var value: Any {
        return switch self {
        case .key(let data):
            data
        case .value(let data):
            data
        case .needsReturnData:
            true as CFBoolean
        case .limitOne:
            kSecMatchLimitOne
        }
    }
    
    var key: String {
        return switch self {
        case .key(_):
            kSecAttrAccount as String
        case .value(_):
            kSecValueData as String
        case .needsReturnData:
            kSecReturnData as String
        case .limitOne:
            kSecMatchLimit as String
        }
    }
}
