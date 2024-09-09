//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

public enum KDSIcons: KDSAssetsType {
    
    /// 􀒂
    case favorite
    
    /// 􀊼
    case favoriteSelected
    
    /// 􀈂
    case share
    
    /// 􀎞
    case tabCharacters
    
    
    public static func favoriteIcon(basedOn status: Bool) -> KDSIcons {
        return status ? .favoriteSelected : .favorite
    }
    
    
    public var file: KDSFile {
        return switch self {
        case .favorite: KDSFile(systemName: "suit.heart")
        case .favoriteSelected: KDSFile(systemName: "suit.heart.fill")
        case .share: KDSFile(systemName: "square.and.arrow.up")
        case .tabCharacters: KDSFile(systemName: "house")
        }
    }
}
