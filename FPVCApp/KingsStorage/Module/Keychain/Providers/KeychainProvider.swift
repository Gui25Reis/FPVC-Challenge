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


public protocol KeychainProvider {
    
    @discardableResult
    func create(_ data: CFDictionary) -> Bool
    
    @discardableResult
    func read(_ data: CFDictionary, result: inout AnyObject?) -> Bool
    
    @discardableResult
    func delete(_ data: CFDictionary) -> Bool
}
