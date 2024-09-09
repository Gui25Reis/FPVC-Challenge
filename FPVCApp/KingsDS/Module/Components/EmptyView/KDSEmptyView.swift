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


open class KDSEmptyView: KDSStack, KDSViewCode {
    
    public var viewModel: KDSEmptyViewVM?
    
    public var automaticallySetConstraintsAtSuperview = true
    
    
    // Componentes UI
    private(set) public lazy var imageView: KDSImageView = {
        let view = KDSImageView(kdsImage: viewModel?.image)
        return view
    }()
    
    private(set) public lazy var titleLabel: KDSLabel = {
        let label = KDSTitleLabel()
        label.text = viewModel?.title
        label.textAlignment = .center
        label.autoAdjustBasedOnText()
        return label
    }()
    
    private(set) public lazy var messageLabel: KDSLabel = {
        let label = KDSBodyLabel()
        if let attributted = viewModel?.attributted {
            label.setText(attributted.0, icon: attributted.1)
        } else {
            label.text = viewModel?.message
        }
        label.textAlignment = .center
        label.autoAdjustBasedOnText()
        return label
    }()
    
    private(set) public lazy var button: KDSButton = {
        let button = KDSTextButton(with: viewModel?.buttomVM)
        return button
    }()
    
    
    // MARK: - Construtores
    public init(viewModel: KDSEmptyViewVM) {
        super.init(frame: .zero)
        self.viewModel = viewModel
        setupStack()
    }
    
    required public init(coder: NSCoder) {
        super.init(coder: coder)
        /* Sem implementação */
    }
    
    
    // MARK: - Ciclo de Vida
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard needsToCreateHierarchy else { return }
        setupView()
    }
    
    
    // MARK: - KDSViewCode
    @objc public func setupHierarchy() {
        setupStackContent()
    }
    
    @objc public func setupConstraints() {
        guard let superview else { return }
        
        var constraints = [NSLayoutConstraint]()
        
        if automaticallySetConstraintsAtSuperview {
            constraints += centerView(on: superview, lateralSpace: 16)
        }
        
        if viewModel?.hasImage == true {
            constraints += [
                imageView.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 0.2),
                imageView.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.5)
            ]
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    // MARK: - Configurações
    open func setupStackContent() {
        guard let viewModel else { return }
        
        if viewModel.hasImage {
            addViewInStack(imageView)
        }
        
        addViewInStack(titleLabel)
        addViewInStack(messageLabel)
        
        if viewModel.hasButton {
            addViewInStack(button)
        }
    }
    
    
    public func setupStack() {
        spacing = 16
        axis = .vertical
        distribution = .equalSpacing
        alignment = .center
        isHidden = true
    }
}
