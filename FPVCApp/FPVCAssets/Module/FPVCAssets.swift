//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import KingsDS


public enum FPVCAsset: KDSAssetsType {
    case badRequest
    case noFavoriteContent
    case noSearchResults
    case example
    case imageEmptyState
    
    
    public var file: KDSFile {
        return switch self {
        case .badRequest:
            svgFile(named: "Cap_Escudo_Parede")
        case .noFavoriteContent:
            svgFile(named: "Dead_Aranha")
        case .noSearchResults:
            svgFile(named: "Groot_01")
        case .example:
            pngFile(named: "Wolwerine")
        case .imageEmptyState:
            pngFile(named: "MarvelFolder")
        }
    }
    
    
    /* Aux */
    private func svgFile(named: String) -> KDSFile {
        KDSFile(name: named, type: .svg, bundle: Bundle.fpvc)
    }
    
    private func pngFile(named: String) -> KDSFile {
        KDSFile(name: named, type: .png, bundle: Bundle.fpvc)
    }
}
