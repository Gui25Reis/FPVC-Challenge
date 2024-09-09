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


class FavoriteController: UIViewController {
    
    override var controllerTitle: String? { "Favoritos" }
    
    lazy var screen: HomeScreen = {
        let view = HomeScreen()
//        charactersHandler = CharacterCollectionHandler(collection: view.characterCollection)
//        charactersHandler?.delegate = self
        return view
    }()
    
    
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
//        fetchCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
//        charactersHandler?.updateLastSelectedCellIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("[Favorite] \(#function)")
    }
    
    
    
    // MARK: - Configurações
    private func setupNavigation() {
        navigationItem.title = controllerTitle
        navigationItem.largeTitleDisplayMode = .always
    }
}
