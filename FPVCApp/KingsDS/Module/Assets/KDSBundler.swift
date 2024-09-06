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


public class KDSBundler {
    /* Sem implementação */
}


public extension Bundle {
    
    static var kingsDS: Bundle { Bundle(for: KDSBundler.self) }
}

