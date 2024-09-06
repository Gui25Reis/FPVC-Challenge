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


open class KDSButtonViewModel {
    public var title: String
    public var action: (UIButton) -> Void
    
    
    public init(title: String, action: @escaping (UIButton) -> Void) {
        self.title = title
        self.action = action
    }
}
