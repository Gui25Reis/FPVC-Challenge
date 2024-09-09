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


public protocol StorageHadler {
    
    associatedtype StorageData
    
    func save(_ data: StorageData, forKey key: String)
    
    func retrieve(forKey key: String) -> StorageData?
    
    func retrieveAll() -> [StorageData]
    
    func delete(forKey key: String)
    
    func cleanAll()
    
    func saveChanges()
}


public extension StorageHadler {
    
    func saveChanges() {
        /* Mantendo implementação opcional */
    }
}
