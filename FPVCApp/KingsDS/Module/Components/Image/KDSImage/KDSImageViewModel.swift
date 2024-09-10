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


public struct KDSImageViewModel {
    var asset: KDSAssetsType
    var color: UIColor?
    var mode: UIImage.RenderingMode
    
    
    public init(asset: KDSAssetsType, color: UIColor? = nil, mode: UIImage.RenderingMode? = nil) {
        self.asset = asset
        self.color = color
        self.mode = mode ?? .automatic
    }
}
