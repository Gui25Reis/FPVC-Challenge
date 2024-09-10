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


public extension UIEdgeInsets {
    
    /// Soma dos valores laterais: left & right
    var horizontals: CGFloat { self.left + self.right }
    
    /// Soma dos valores verticais: top & bottom
    var verticals: CGFloat { self.top + self.bottom }
    
    
    // MARK: - Construtores
    init(space: CGFloat) {
        self.init(top: space, left: space, bottom: space, right: space)
    }
    
    init(horizontals space: CGFloat) {
        self.init(top: 0, left: space, bottom: 0, right: space)
    }
    
    init(verticals space: CGFloat) {
        self.init(top: space, left: 0, bottom: space, right: 0)
    }
}
