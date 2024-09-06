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
}
