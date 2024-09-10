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


extension UIScrollView {
    
    @objc open func removeScrollIndicators() {
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    @objc open func blockBouncingWhenScrolling() {
        alwaysBounceVertical = false
        alwaysBounceHorizontal = false
        bounces = false
    }
}
