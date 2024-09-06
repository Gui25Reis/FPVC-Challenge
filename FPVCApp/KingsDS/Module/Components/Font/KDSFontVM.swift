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


public struct KDSFontVM {
    public var size: CGFloat
    public var weight: UIFont.Weight
    public var color: UIColor?
    
    
    public init(size: CGFloat, weight: UIFont.Weight, color: UIColor? = nil) {
        self.size = size
        self.weight = weight
        self.color = color
    }
}
