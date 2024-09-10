//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

enum AppCacheKeys {
    
    case firstInstallation
    case marvelPriv
    case marvelPubli
    
    var keyName: String {
        return switch self {
        case .firstInstallation:
            "first_installation"
        case .marvelPriv:
            "marvelPriv"
        case .marvelPubli:
            "marvelPublic"
        }
    }
}
