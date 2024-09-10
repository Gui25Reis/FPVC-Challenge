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
import KingsDS


class InfosScreen: UIView, KDSViewCode {
    
    /* Componentes UI */
    lazy var tableView: KDSTable = {
        let view = KDSTable(style: .insetGrouped)
        view.removeScrollIndicators()
        view.setupDynamicCellHeight(estimatedHeight: 44)
        view.cleanExtraVerticalSpaces()
        view.emptyHeaderNFooterViews()
        view.backgroundColor = .clear
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
        addSubview(tableView)
    }
    
    func setupConstraints() {
        let constraints = tableView.strechToBounds(of: self)
        NSLayoutConstraint.activate(constraints)
    }
    
    func additionalSetup() {
        backgroundColor = KDSColors.background
    }
}
