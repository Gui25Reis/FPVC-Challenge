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


struct KeychainDict {
    
    var query: CFDictionary { mainQuery as CFDictionary }
    
    
    private var mainQuery: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword
    ]
    
    
    mutating func add(parameter: KeychainParameters) {
        mainQuery[parameter.key] = parameter.value
    }
    
    mutating func add(parameters: [KeychainParameters]) {
        parameters.forEach { add(parameter: $0) }
    }
}
