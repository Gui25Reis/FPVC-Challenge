//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import Foundation


public enum ImagesDownloaderErrors: Error {
    case badURL
    case noData
    case badCreation
    
    var desciption: String {
        return switch self {
        case .badURL: "Erro de URL"
        case .noData: "Dado inválido"
        case .badCreation: "Erro na criação da imagem"
        }
        
    }
}
