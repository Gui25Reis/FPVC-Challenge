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


class HomeScreen: UIView, KDSViewCode {
    
    lazy var emptyView: KDSEmptyView = {
        let viewModel = KDSEmptyViewVM(
            image: KDSImage(asset: FPVCAsset.badRequest),
            title: "Algo de errado não está certo!",
            message: "Não foi possível carregar os personagens! Verifique a sua conexão e tente novamente.",
            buttomVM: KDSButtonViewModel(
                title: "Tentar novamente",
                action: { _ in print("Cliquei em tentar novamente") }
            )
        )
        
        let view = KDSEmptyView(viewModel: viewModel)
        return view
    }()
    
    
    lazy var characterCollection: KDSCollection = {
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
    
    
    // MARK: - KDSViewCode
    func setupHierarchy() {
//        addSubview(emptyView)
        addSubview(characterCollection)
    }
    
    func setupConstraints() {
        let constraints = characterCollection.strechToBounds(of: self)
        NSLayoutConstraint.activate(constraints)
    }
    
    func additionalSetup() {
        backgroundColor = KDSColors.background
    }
}
