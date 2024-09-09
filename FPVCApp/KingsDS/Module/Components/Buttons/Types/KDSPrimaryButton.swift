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


open class KDSPrimaryButton: KDSButton, KDSViewCode {
    
    var buttonHeight: CGFloat { 44 }
    
    
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
            heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    @objc public func additionalSetup() {
        setupBorder()
        setupMainColor()
    }
    
    
    // MARK: - Configurações
    private func setupBorder() {
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }
    
    private func setupMainColor() {
        mainColor = KDSColors.accentButton
    }
}
