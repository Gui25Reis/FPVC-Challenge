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


extension UIActivityIndicatorView {
    
    func centerAtSuperview() {
        guard let superview else { return }
        center(at: superview)
    }
    
    func center(at view: UIView) {
        center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds))
    }
}
