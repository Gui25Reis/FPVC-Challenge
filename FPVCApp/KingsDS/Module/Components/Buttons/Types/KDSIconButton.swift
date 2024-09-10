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


open class KDSIconButton: KDSButton, KDSViewCode {
    
    open lazy var buttonHeight: CGFloat = 32
    
    open var image: KDSImage? {
        set(value) { setImage(value?.imageCreated, for: .normal) }
        get { KDSImage(image: image(for: .normal)) }
    }
    
    
    // MARK: - Construtores
    public init(image: KDSImage) {
        super.init()
        self.image = image
        setImage(image.imageCreated, for: .normal)
        tintColor = KDSColors.accentButton
    }
    
    public required init?(coder: NSCoder) { nil }
    
    
    // MARK: - Ciclo de Vida
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard needsToCreateHierarchy else { return }
        setupView()
    }
    
    
    // MARK: - KDSViewCode
    @objc public func setupHierarchy() {
        /* Sem implementação */
    }
    
    @objc public func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: buttonHeight),
            widthAnchor.constraint(equalToConstant: buttonHeight),
        ])
    }
    
    @objc public func additionalSetup() {
        /* Sem implementação */
        imageView?.contentMode = .scaleAspectFit
        
        contentVerticalAlignment = .fill
        contentHorizontalAlignment = .fill
    }
}
