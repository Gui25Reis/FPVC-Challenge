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
    var available = 0
    var limitePerRequest = 0
    var requestsCount = 0 
    
    var cachedLoop = [Int:[Int]]()
    
    var isLimitReached: Bool { requestsCount * limitePerRequest >= available }
    
    
    var randomOffSet: Int {
        if cachedLoop[limitePerRequest].isNotNil {
            let number = cachedLoop[limitePerRequest]?.removeRandomElement()
            return number.defaultValue
        }
        
        let possibleNumbers = stride(from: 0, to: available, by: limitePerRequest)
        var array = Array(possibleNumbers)
        
        let number = array.removeRandomElement()
        cachedLoop[limitePerRequest] = array
        
        return number.defaultValue
    }
    
    
    func prepareForNewRequest() {
        available = 0
        limitePerRequest = 0
        
        requestsCount = 0
        
        cachedLoop = [Int:[Int]]()
    }
}
