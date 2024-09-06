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


open class KDSStack: UIStackView, KDSComponent {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    public init() {
        super.init(frame: .zero)
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
    }
}
