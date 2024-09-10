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


protocol CharacterFooterDelegate: AnyObject {
    
    func paginationAction()
}


class CharacterFooter: UICollectionReusableView, KDSCollectionReusableViewType, KDSViewCode, KDSSpinnerHandler {
    
    static var identifier: String { "IdCharacterFooter" }
        
    weak var delegate: CharacterFooterDelegate?
    
    // Componentes UI
    private(set) public lazy var paginationButton: KDSButton = {
        let button = KDSTextButton(with: KDSButtonViewModel(
            title: "Carregar novos dados",
            action: { [weak self] _ in self?.fetchNewPagination() }
        ))
        return button
    }()
    
    var loadingIndicator: UIActivityIndicatorView?
    
    
    // MARK: - Ciclo de Vida
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard needsToCreateHierarchy else { return }
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        removeSpinner()
        paginationButton.isHidden = false
    }
    
    
    // MARK: - Encapsulamento
    func isFetchingNewData() {
        showSpinner(style: .large)
        paginationButton.isHidden = true
    }
    
    
    // MARK: - KDSViewCode
    func setupHierarchy() {
        addSubview(paginationButton)
    }
    
    func setupConstraints() {
        let constraints = paginationButton.centerView(on: self)
        NSLayoutConstraint.activate(constraints)
    }
    
    
    // MARK: - Configurações
    private func fetchNewPagination() {
        isFetchingNewData()
        delegate?.paginationAction()
    }
}
