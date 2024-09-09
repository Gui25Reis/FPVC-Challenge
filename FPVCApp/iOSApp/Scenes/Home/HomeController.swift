//
//  ViewController.swift
//  FPVCApp
//
//  Created by Gui Reis on 29/08/24.
//

import UIKit
import KingsDS
import KingsFoundation


class HomeViewController: UIViewController, CharacterCollectionHandlerDelegate, HomeScreenDelegate {
    
    override var controllerTitle: String? { "Personagens" }
    
    lazy var screen: HomeScreen = {
        let view = HomeScreen()
        view.delegate = self
        return view
    }()
    
    
    let api = MarvelCharacterAPI()
    let network = NetworkHandler<MarvelCharacterAPI>()
    
    var dispatcher = KFDispatcherQueue(provider: DispatchQueue.main)
    
    
    var charactersHandler: CharacterCollectionHandler?
    
    
    // MARK: - Construtores
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTabBar(image: KDSImage(asset: KDSIcons.tabCharacters))
    }
    
    required init?(coder: NSCoder) { nil }
    
    
    
    // MARK: - Ciclo de Vida
    override func loadView() {
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        fetchCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        charactersHandler?.updateLastSelectedCellIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        FavoriteManager.shared.saveChangesIfNeeded()
    }
    
    
    
    // MARK: - Configurações
    private func setupNavigation() {
        showTabBar()
        navigationItem.title = controllerTitle
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupCollection() {
        charactersHandler = CharacterCollectionHandler(collection: screen.characterCollection)
        charactersHandler?.delegate = self
    }
    
    
    private func fetchCharacters() {
        try? network.makeRequest(for: api) { [weak self] result in
            switch result {
            case .success(let data):
                self?.api.saveResponseIfNeeded(data)
                self?.updateCollectionData(with: data)
                
            case .failure(_):
                self?.charactersHandler?.newData([])
            }
        }
    }
    
    private func updateCollectionData(with result: MarvelCharacterAPI.SuccessModel) {
        print("[Home] \(#function)")
        guard let result = result.data?.results else { return }
        
        print("[Home] Filtrando dados")
        var validData = [MarvelCharacterData]()
        for data in result {
            let cellData = MarvelCharacterData(from: data)
            validData.appendIfExists(cellData)
        }
        
        FavoriteManager.shared.updateDataFromRequest(&validData)
        
        print("[Home] Dados para serem apresentados: \(validData.count)")
        print("[Home] Dados: \(validData)")
        charactersHandler?.newData(validData)
    }
}


// MARK: - + CharacterCollectionHandlerDelegate
extension HomeViewController {
    
    func fetchMoreData() {
        api.prepareForPagination()
        fetchCharacters()
    }
    
    func routeToInfos(with data: MarvelCharacterData) {
        let controller = InfosController(characterInfos: data)
        navigationController?.pushViewController(controller, animated: true)
    }
}


// MARK: - + HomeScreenDelegate
extension HomeViewController {
    
    func tryAgainAction() {
        print("Tentando de novo")
        screen.hideEmptyView()
        screen.characterCollection.showSpinner(style: .large)
        fetchCharacters()
    }
}
