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


open class KDSLabel: UILabel, KDSComponent {
    
    var defaultFontConfig: KDSFontVM? { nil }
    
    
    // MARK: - Construtores
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    public convenience init() {
        self.init(frame: .zero)
    }
    
    required public init?(coder: NSCoder) { nil }
    
    
    // MARK: - Encapsulamento
    public func setupFont(with fontVM: KDSFontVM?) {
        guard let fontVM else { return }
        font = .systemFont(ofSize: fontVM.size, weight: fontVM.weight)
        textColor = fontVM.color
    }
    
    
    // MARK: - KDSComponent
    public func initialSetup() {
        activateConstraints()
        setupFont(with: defaultFontConfig)
    }
    
    
    final public func setText(_ text: String, icon image: KDSImage) {
        let attributedString = NSMutableAttributedString(string: text)
        
        let range = (text as NSString).range(of: "$@")
        
        // Se encontrar o marcador, fazer a substituição
        guard range.location != NSNotFound, let icon = image.imageCreated
        else {
            self.text = text
            return
        }
        
        let iconAttachment = NSTextAttachment()
        iconAttachment.image = icon.withColor(textColor)
        
        let iconSize = font.pointSize * 1
        iconAttachment.bounds = CGRect(x: 0, y: -3, width: iconSize+3, height: iconSize)
        
        let iconString = NSAttributedString(attachment: iconAttachment)
        
        attributedString.replaceCharacters(in: range, with: iconString)
        attributedText = attributedString
    }
}
