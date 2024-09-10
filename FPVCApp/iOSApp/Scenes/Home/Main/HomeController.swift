//
//  ViewController.swift
//  FPVCApp
//
//  Created by Gui Reis on 29/08/24.
//

import UIKit
import KingsDS
import KingsFoundation


protocol HomePresenter: UIViewController {
    
    func updateCollectionData(with newData: [MarvelCharacterData], canLoadMoreData: Bool)
}


class HomeViewController: UIViewController, HomePresenter, HomeScreenDelegate, HomeCollectionHandlerDelegate {
    
    override var controllerTitle: String? { "Personagens" }
    
    lazy var screen: HomeScreen = {
        let view = HomeScreen()
        view.delegate = self
        return view
    }()
    
    lazy var searchHandler: KDSSearchController? = {
        let search = viewModel?.createSearchController()
        search?.setupPlaceHolder(text: "Buscar..", color: .black)
        search?.infosColor = .black
        search?.accentColor = KDSColors.accentButton
        return search
    }()
    
    var collectionHandler: HomeCollectionHandlerLogic?
    
    var dispatcher: KFDispatcherQueue?
    var viewModel: HomeViewModelLogic?
    
    
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
        setupCollectionHandler()
        viewModel?.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        collectionHandler?.updateLastSelectedCellIfNeeded()
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
        
        navigationItem.hidesSearchBarWhenScrolling = true
    }

    func createSearchIfNeeded() {
        dispatcher?.onMainThread {
            guard self.navigationItem.searchController.isNil else { return }
            self.navigationItem.searchController = self.searchHandler
        }
    }
    
    func setupCollectionHandler() {
        collectionHandler = HomeFactory.makeCollectionHandler(
            screen.collection, delegate: self
        )
    }
}


// MARK: - + HomePresenter
extension HomeViewController {
    
    func updateCollectionData(with newData: [MarvelCharacterData], canLoadMoreData: Bool) {
        collectionHandler?.canLoadMoreData = canLoadMoreData
        collectionHandler?.newData(newData)
        
        guard newData.isNotEmpty else { return }
        createSearchIfNeeded()
    }
}


// MARK: - + HomeCollectionHandlerDelegate
extension HomeViewController {
    
    func fetchMoreData() {
        viewModel?.fetchMoreData()
    }
    
    func routeToInfos(with data: MarvelCharacterData) {
        let controller = InfosFactory.makeControler(data: data)
        navigationController?.pushViewController(controller, animated: true)
    }
}


// MARK: - + HomeScreenDelegate
extension HomeViewController {
    
    func tryAgainAction() {
        screen.prepareToTryAgain()
        viewModel?.tryNewFetchAgain()
    }
}
