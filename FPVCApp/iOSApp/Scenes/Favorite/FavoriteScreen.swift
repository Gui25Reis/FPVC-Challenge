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


class FavoriteScreen: UIView, KDSViewCode, KDSEmptyViewHandler {
    
    lazy var emptyView: KDSEmptyView = {
        let view = KDSEmptyView(viewModel: emptyViewVM)
        return view
    }()
    
    var emptyViewVM: KDSEmptyViewVM = {
        KDSEmptyViewVM(
            image: KDSImage(asset: FPVCAsset.noFavoriteContent),
            title: "Seus favoritos!",
            attributted: (
                "Clique no $@ para favoritar seu personagem preferido!",
                KDSImage(asset: KDSIcons.favorite)
            )
        )
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
        addSubview(characterCollection)
        addSubview(emptyView)
    }
    
    func setupConstraints() {
        let constraints = characterCollection.strechToBounds(of: self)
        NSLayoutConstraint.activate(constraints)
    }
    
    func additionalSetup() {
        backgroundColor = KDSColors.background
    }
}
