//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import KingsFoundation


class PaginationData {
    var available: Int = 0
    var didAsked = [Int:Bool]()
    var limitePerRequest = 0
    
    var cachedLoop = [Int:[Int]]()
    
    var randomOffSet: Int {
        if cachedLoop[limitePerRequest].isNotNil {
            let number = cachedLoop[limitePerRequest]?.removeRandomElement()
            return number ?? 0
        }
        
        let possibleNumbers = stride(from: 0, to: available, by: limitePerRequest)
        var array = Array(possibleNumbers)
        
        let number = array.removeRandomElement()
        cachedLoop[limitePerRequest] = array
        
        return number ?? 0
    }
}
