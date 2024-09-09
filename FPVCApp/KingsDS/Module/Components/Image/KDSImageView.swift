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
import KingsFoundation


public typealias LoadingSpinnerStyle = UIActivityIndicatorView.Style


open class KDSImageView: UIImageView, KDSComponent, KDSSpinnerHandler {
    
    /* Overrides */
    open override var bounds: CGRect {
        didSet { createSpinnerIfNeeded() }
    }
    
    open override var image: UIImage? {
        didSet { removeSpinner() }
    }
    
    
    /* KDSSpinnerHandler */
    public var loadingIndicator: UIActivityIndicatorView?
    
    public var canShowSpinner: Bool {
        loadingIndicator.isNil && !bounds.isEmpty && image.isNil
    }
    
    
    // Outros
    var spinnerStyle: LoadingSpinnerStyle?
    
    private(set) public var imageVM: KDSImageViewModel?
    
    public var kdsImage: KDSImage?

    
    // MARK: - Construtores
    public init() {
        super.init(frame: .zero)
        initialSetup()
    }
    
    public convenience init(loadingWithStyle style: LoadingSpinnerStyle) {
        self.init()
        spinnerStyle = style
    }
    
    public convenience init(kdsImage: KDSImage?) {
        self.init()
        self.kdsImage = kdsImage
        setupImage(with: kdsImage)
    }
    
    required public init?(coder: NSCoder) { nil }
    
    // Destrutor
    deinit {
        kdsImage?.cleanObject()
        kdsImage = nil
    }
    
    
    // MARK: - Ciclo de Vida
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard needsToCreateHierarchy else { return }
        createSpinnerIfNeeded()
    }
    
    
    // MARK: - Encapsulamento
    final public func setupImage(with image: KDSImage?) {
        kdsImage = image
        prepare(image: image?.imageCreated)
    }
    
    final public func prepare(image: UIImage?) {
        guard let image else { return }
        kdsImage = KDSImage(image: image)
        
        image.prepareForDisplay { image in
            KDSMainDispatcher.onMainThread { self.image = image }
        }
    }
    
    
    final public func removeImage() {
        image = nil
        imageVM = nil
    }
    
    
    // MARK: - KDSComponent
    open func initialSetup() {
        activateConstraints()
        contentMode = .scaleAspectFit
    }
    
    
    // MARK: - Configurações
    private func createSpinnerIfNeeded() {
        guard let spinnerStyle, canShowSpinner else { return }
        showSpinner(style: spinnerStyle)
    }
}
