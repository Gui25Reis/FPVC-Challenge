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


class SearchResultScreen: UIView, KDSViewCode, KDSEmptyViewHandler {
    
    /* Componentes UI */
    lazy var emptyView: KDSEmptyView = {
        let view = KDSEmptyView(viewModel: emptyViewVM)
        return view
    }()
    
    lazy var emptyViewVM: KDSEmptyViewVM = {
        KDSEmptyViewVM(
            image: KDSImage(asset: FPVCAsset.noSearchResults),
            title: "Nenhum resultado",
            message: "Nenhum dado foi encontrado para a sua pesquisa."
        )
    }()
    
    
    lazy var collection: KDSCollection = {
        let view = KDSCollection()
        view.removeScrollIndicators()
        view.isAllowedToShowSpinner = false
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
        collection.isAllowedToShowSpinner = true
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
