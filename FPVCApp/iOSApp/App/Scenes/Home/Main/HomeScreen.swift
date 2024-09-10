//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import KingsDS
import FPVCAssets
import UIKit


protocol HomeScreenDelegate: AnyObject {
    
    func tryAgainAction()
}


class HomeScreen: UIView, KDSViewCode, KDSEmptyViewHandler {
    
    weak var delegate: HomeScreenDelegate?
    
    
    /* Componentes UI */
    lazy var emptyView: KDSEmptyView = {
        let view = KDSEmptyView(viewModel: emptyViewVM)
        return view
    }()
    
    lazy var emptyViewVM: KDSEmptyViewVM = {
        KDSEmptyViewVM(
            image: KDSImage(asset: FPVCAsset.badRequest),
            title: "Algo de errado não está certo!",
            message: "Não foi possível carregar os personagens! Verifique a sua conexão e tente novamente.",
            buttomVM: KDSButtonViewModel(
                title: "Tentar novamente",
                action: { [weak self] _ in self?.delegate?.tryAgainAction() }
            )
        )
    }()
    
    
    lazy var collection: KDSCollection = {
        let view = KDSCollection()
        view.removeScrollIndicators()
        view.backgroundColor = .clear
        
        let defaultSpace: CGFloat = 10
        view.padding = UIEdgeInsets(space: defaultSpace)
        view.layout.beetweenSpace = defaultSpace
        return view
    }()
    
    
    // MARK: - Ciclo de Vida
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard needsToCreateHierarchy else { return }
        setupView()
    }
    
    
    // MARK: - Encapsulamento
    
    func prepareToTryAgain() {
        hideEmptyView()
        collection.showSpinner(style: .large)
    }
    
    
    // MARK: - KDSViewCode
    func setupHierarchy() {
        addSubview(collection)
        addSubview(emptyView)
    }
    
    func setupConstraints() {
        let constraints = collection.strechToBounds(of: self)
        NSLayoutConstraint.activate(constraints)
    }
    
    func additionalSetup() {
        backgroundColor = KDSColors.background
    }
}
