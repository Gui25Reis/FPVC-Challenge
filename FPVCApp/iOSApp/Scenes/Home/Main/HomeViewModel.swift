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
import KingsNetwork


protocol HomeViewModelLogic: ViewModelType {
    
    func tryNewFetchAgain()
        
    func createSearchController() -> KDSSearchController
    
    func fetchMoreData()
    
    func fetchData()
}


class HomeViewModel: HomeViewModelLogic, KDSSearchDelegate, MarvelCharacterWorkerDelegate {
    
    weak var mainBinding: HomePresenter?
    
    private var worker: (any MarvelCharacterWorkerLogic)? {
        isSearching ? searchWorker : mainWorker
    }
    
    private var presenter: HomePresenter? {
        isSearching ? searchResult : mainBinding
    }
    
    var mainWorker: (any MarvelCharacterWorkerLogic)?
    var searchWorker: (any MarvelCharacterWorkerLogic)?
    
    var isSearching = false
    
    lazy var searchResult: SearchResultPresenter = {
        SearchResultFactory.makeController(delegate: self)
    }()
    
    
    // MARK: - Configurações
    private func retrieveValidData(with result: MarvelCharacterAPI.SuccessModel) -> [MarvelCharacterData] {
        guard let result = result.data?.results else { return [] }
        
        var validData = [MarvelCharacterData]()
        for data in result {
            let cellData = MarvelCharacterData(from: data)
            validData.appendIfExists(cellData)
        }
        
        FavoriteManager.shared.updateDataFromRequest(&validData)
        return validData
    }
}


// MARK: - + HomeViewModelLogic
extension HomeViewModel {
    
    func fetchData() {
        worker?.makeRequest()
    }
    
    func fetchMoreData() {
        worker?.makePaginationRequest()
    }
    
    func tryNewFetchAgain() {
        worker?.makeRequest()
    }
    
    func createSearchController() -> KDSSearchController {
        let searchResult = searchResult
        let search = KDSSearchController(searchResultsController: searchResult)
        search.searchDelegate = self
        return search
    }
}


// MARK: - + MarvelCharacterWorkerDelegate
extension HomeViewModel {
    
    func didSucceed(with data: MarvelCharacterAPI.SuccessModel, hasMoreData: Bool) {
        let validData = retrieveValidData(with: data)
        presenter?.updateCollectionData(with: validData, canLoadMoreData: hasMoreData)
    }
    
    func didFail(with data: NetworkError<MarvelCharacterAPI>) {
        presenter?.updateCollectionData(with: [], canLoadMoreData: false)
    }
}


// MARK: - + KDSSearchDelegate
extension HomeViewModel {
    
    func searchWith(data text: String) {
        isSearching = true
        searchResult.didStartSearching()
        worker?.makeSearchRequest(with: text)
    }
    
    func searchCanceled() {
        isSearching = false
        searchResult.didStopSearching()
    }
}


// MARK: - + KDSSearchDelegate
extension HomeViewModel: HomeCollectionHandlerDelegate {
    
    func routeToInfos(with data: MarvelCharacterData) {
        let controller = InfosFactory.makeControler(data: data)
        mainBinding?.navigationController?.pushViewController(controller, animated: true)
    }
}
