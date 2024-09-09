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


public typealias KDSNavButtonAction = (KDSNavButton) -> Void

open class KDSNavButton: UIBarButtonItem {
    
    public var kdsImage: KDSImage? {
        didSet { updateImage() }
    }
    
    /// Ação do botão
    public var mainAction: KDSNavButtonAction?
    
    
    // MARK: - Construtores
    public init(image: KDSImage, color: UIColor? = nil, action: @escaping KDSNavButtonAction) {
        super.init()
        initialSetup()
        mainAction = action
        tintColor = color
        kdsImage = image
        updateImage()
    }
    
    
    public init(title: String, color: UIColor? = nil, action: @escaping KDSNavButtonAction) {
        super.init()
        initialSetup()
        mainAction = action
        self.title = title
        tintColor = color
    }
    
    public required init?(coder: NSCoder) { nil }
    
    
    // MARK: - Configurções
    @objc private func buttonAction() {
        mainAction?(self)
    }
    
    private func updateImage() {
        image = kdsImage?.imageCreated
    }
    
    /* KDSComponent */
    public func initialSetup() {
        target = self
        action = #selector(buttonAction)
    }
}
