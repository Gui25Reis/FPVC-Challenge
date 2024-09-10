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
import KingsFoundation


protocol FavoritePresenter {
     
    func route(to controller: UIViewController)
}


class FavoriteController: UIViewController, FavoritePresenter {
    
    override var controllerTitle: String? { "Favoritos" }
    
    lazy var screen = FavoriteScreen()
    
    var viewModel: FavoriteViewModelLogic?
    
    
    // MARK: - Construtores
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTabBar(image: KDSImage(asset: KDSIcons.favorite))
    }
    
    required init?(coder: NSCoder) { nil }
    
    
    // MARK: - Ciclo de Vida
    override func loadView() {
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.setupCollection(screen.characterCollection)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.updateTableData()
    }
    
        
    // MARK: - Configurações
    private func setupNavigation() {
        showTabBar()
        navigationItem.title = controllerTitle
        navigationItem.largeTitleDisplayMode = .always
    }
}


// MARK: - + FavoriteCharacterCollectionHandlerDelegate
extension FavoriteController {
    
    func route(to controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}
