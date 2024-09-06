//
//  ViewController.swift
//  FPVCApp
//
//  Created by Gui Reis on 29/08/24.
//

import UIKit
import KingsDS
import KingsFoundation


class HomeViewController: UIViewController {
    
    lazy var screen: HomeScreen = {
        let view = HomeScreen()
        charactersHandler = CharacterCollectionHandler(collection: view.characterCollection)
        charactersHandler?.delegate = self
        return view
    }()
    
    
    let api = MarvelCharacterAPI()
    let network = NetworkHandler<MarvelCharacterAPI>()
    
    var dispatcher = KFDispatcherQueue(provider: DispatchQueue.main)
    
    
    var charactersHandler: CharacterCollectionHandler?
    
    
    // MARK: - Ciclo de Vida
    override func loadView() {
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    
    
    // MARK: - Configurações
    
    private func setupNavigation() {
        navigationItem.title = "Personagens"
        navigationItem.largeTitleDisplayMode = .always
    }
    
    
    
    private func fetchCharacters() {
//        api.addParameter(data: .nameStartsWith("Galac"))
        
        try? network.makeRequest(for: api) { [weak self] result in
            switch result {
            case .success(let data):
                self?.api.saveResponseIfNeeded(data)
                self?.updateCollectionData(with: data)
                
            case .failure(_):
                print("Falha na request")
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
        
        print("[Home] Dados para serem apresentados: \(validData.count)")
        print("[Home] Dados: \(validData)")
        charactersHandler?.newData(validData)
    }
}



extension HomeViewController: CharacterCollectionHandlerDelegate {
    
    func fetchMoreData() {
        api.prepareForPagination()
        fetchCharacters()
    }
}
