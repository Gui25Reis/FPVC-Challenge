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


class NSCoderMock: NSCoder {
    
    override func decodeObject(forKey key: String) -> Any? { nil }
    
    override func encode(_ object: Any?, forKey key: String) {
        /* Sem implementação */
    }
    
    override var allowsKeyedCoding: Bool { true }
}
