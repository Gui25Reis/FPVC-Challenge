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


public extension String {
    
    @inlinable var isNotEmpty: Bool {
        isEmpty == false
    }
    
    /// Transforma a string em uma URL
    var asURL: URL? {
        URL(string: self)
    }
    
    
    var toInt: Int {
        Int(self).defaultValue
    }
    
    func isDifferent(then text: String) -> Bool {
        self != text
    }
    
    func toDate(with formatType: KDSDateFormats) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatType.format
        dateFormatter.timeZone = Date.brazilTimeZone
        dateFormatter.locale = Date.brazilLocale
        
        return dateFormatter.date(from: self)
    }
}
