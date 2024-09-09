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


public extension Date {
    
    static var now: Date { Date() }
    
    static var brazilTimeZone: TimeZone? {
        return TimeZone(abbreviation: "GMT-3")
    }
    
    static var brazilLocale: Locale {
        return Locale(identifier: "pt_BR")
    }
    
    
    func toString(with formatType: KDSDateFormats) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.format
        dateFormatter.timeZone = Self.brazilTimeZone
        dateFormatter.locale = Self.brazilLocale
        
        return dateFormatter.string(from: self)
    }
}
