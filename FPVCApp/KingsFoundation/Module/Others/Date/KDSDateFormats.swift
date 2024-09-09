//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import UIKit


/// Tipo de formatação de data
public enum KDSDateFormats {
    
    /// Dia / Mês / Ano
    case dma
    
    /// Hora / Minuto
    case hm
    
    /// Hora / Minuto / Segundo
    case hms
    
    /// Hora em formato de ISO
    case iso
    
    /// Dia + hora + minuto
    case complete
    
    /// Dia + Mes escrito + Ano - + Hora e Minuto
    case completeWritten
    
    /// Para colocar no nome de um asset
    case asset
    
    
    
    /* MARK: - Variáveis */
    
    /// Formato da data
    var format: String {
        switch self {
        case .dma:
            return "dd/MM/yy"
        case .hm:
            return "HH:mm"
        case .hms:
            return "HH:mm:ss"
        case .iso:
            return "dd-MM-yy'T'HH:mm:ssZ"
        case .complete:
            return "dd/MM/yy-HH:mm"
        case .completeWritten:
            return "d MMMM yyyy - HH:mm"
        case .asset:
            return "yyyyMMdd-HHmmss"
        }
    }
}
