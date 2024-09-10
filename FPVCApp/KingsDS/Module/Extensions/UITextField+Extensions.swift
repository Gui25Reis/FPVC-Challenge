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


public extension UITextField {
    
    func setupPlaceHolder(text: String, color: UIColor? = nil) {
        guard let color else {
            placeholder = text
            return
        }
        
        attributedPlaceholder = NSAttributedString (
            string: text,
            attributes: [NSAttributedString.Key.foregroundColor: color]
        )
    }
    
    func setupTextsAndIconsColor(for color: UIColor?) {
        rightView?.tintColor = color
        leftView?.tintColor = color
        tintColor = color
        textColor = color
    }
}
