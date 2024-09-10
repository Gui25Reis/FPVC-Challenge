//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

@testable import FPVCApp
import UIKit


enum MockModels {
    
    static func makeValidCoder() -> NSCoder { NSCoderMock() }
}


// MARK: + Marvel
extension MockModels {
    
    enum Marvel {
        
        static func makeCharacterData() -> MarvelCharacterData {
            MarvelCharacterData()
        }
    }
}
