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


class FavoriteController: UIViewController, FavoriteCharacterCollectionHandlerDelegate {
    
    override var controllerTitle: String? { "Favoritos" }
    
    lazy var screen: HomeScreen = {
        let view = HomeScreen()
        return view
    }()
    
    
    var collectionHandler: FavoriteCharacterCollectionHandler?
    var notificator = KFNotificator(provider: NotificationCenter.default)
    
    
    // MARK: - Construtores
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTabBar(image: KDSImage(asset: KDSIcons.favorite))
    }
    
    required init?(coder: NSCoder) { nil }
    
    deinit {
        notificator.unregister(self, key: .coreDateSaving)
    }
    
    
    // MARK: - Ciclo de Vida
    override func loadView() {
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        notificator.register(self, action: #selector(updateTableData), key: .coreDateSaving)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        updateTableData()
    }
    
        
    // MARK: - Configurações
    private func setupNavigation() {
        showTabBar()
        navigationItem.title = controllerTitle
        navigationItem.largeTitleDisplayMode = .always
    }
    
    @objc private func updateTableData() {
        print("[FavoriteController] \(#function)")
        let newData = FavoriteManager.shared.getFavoritedCharacters()
        collectionHandler?.newData(newData)
    }
    
    private func setupCollection() {
        collectionHandler = FavoriteCharacterCollectionHandler(collection: screen.characterCollection)
        collectionHandler?.delegate = self
        updateTableData()
    }
}


// MARK: - + FavoriteCharacterCollectionHandlerDelegate
extension FavoriteController {
    
    func routeToInfos(with data: MarvelCharacterData) {
        let controller = InfosController(characterInfos: data)
        navigationController?.pushViewController(controller, animated: true)
    }
}
