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


protocol SearchResultPresenter: HomePresenter {
    
    func didStartSearching()
    
    func didStopSearching()
}


class SearchResultController: UIViewController, SearchResultPresenter {
    
    lazy var screen = SearchResultScreen()
    
    var collectionHandler: HomeCollectionHandlerLogic?
    
        
    // MARK: - Ciclo de Vida
    override func loadView() {
        view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        screen.collection.isAllowedToShowSpinner = false
        collectionHandler?.updateLastSelectedCellIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        FavoriteManager.shared.saveChangesIfNeeded()
    }
}


// MARK: - + HomePresenter
extension SearchResultController {
    
    func updateCollectionData(with newData: [MarvelCharacterData], canLoadMoreData: Bool) {
        collectionHandler?.canLoadMoreData = canLoadMoreData
        collectionHandler?.newData(newData)
    }
    
    func didStartSearching() {
        collectionHandler?.cleanData()
        screen.prepareToTryAgain()
    }
    
    func didStopSearching() {
        collectionHandler?.cleanData()
    }
}
