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


public typealias StringAttributes = [NSAttributedString.Key: Any]


open class KDSTextButton: KDSButton {
    
    let underlineAttributes: StringAttributes = [
        NSAttributedString.Key.underlineStyle: 1,
        NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular),
        NSAttributedString.Key.foregroundColor: KDSColors.accentButton
    ]
    
    final public override var title: String? {
        set(value) { atributtedTitle = value }
        get { atributtedTitle }
    }
    
        
    // MARK: - Configurações
    
    public override func initialSetup() {
        super.initialSetup()
        setupAttributes()
    }
    
    private func setupAttributes() {
        defaultAttributes = underlineAttributes
    }
}
