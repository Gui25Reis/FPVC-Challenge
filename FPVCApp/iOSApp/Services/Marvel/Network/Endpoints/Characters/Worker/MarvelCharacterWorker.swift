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
import KingsFoundation


// MARK: - Delegate
protocol MarvelCharacterWorkerDelegate: AnyObject {
    func didSucceed(with data: MarvelCharacterAPI.SuccessModel, hasMoreData: Bool)
    func didFail(with data: NetworkError<MarvelCharacterAPI>)
}


// MARK: - MarvelCharacterWorkerLogic
protocol MarvelCharacterWorkerLogic {
    func makeRequest()
    func makePaginationRequest()
    func makeSearchRequest(with searchText: String)
}



class MarvelCharacterWorker: MarvelCharacterWorkerLogic {
    
    var api = MarvelCharacterAPI()
    var network = NetworkHandler<MarvelCharacterAPI>()
    
    weak var delegate: MarvelCharacterWorkerDelegate?
    
    var lastSearchRequest = ""
    
    func makeRequest() {
        try? network.makeRequest(for: api) { [weak self] result in
            switch result {
            case .success(let data): self?.handleSuccess(with: data)
            case .failure(let data): self?.handleFailure(with: data)
            }
        }
    }
    
    func makePaginationRequest() {
        api.prepareForPagination()
        makeRequest()
    }
    
    func makeSearchRequest(with searchText: String) {
        lastSearchRequest.isDifferent(then: searchText)
        ? api.pagination.prepareForNewRequest()
        : Void()
        
        lastSearchRequest = searchText
        api.addParameter(data: .nameStartsWith(searchText))
        makeRequest()
    }
    
    
    // MARK: - Configurações
    private func handleSuccess(with data: MarvelCharacterAPI.SuccessModel) {
        api.pagination.requestsCount += 1
        api.saveResponseIfNeeded(data)
        
        let hasMoreData = !api.pagination.isLimitReached
        delegate?.didSucceed(with: data, hasMoreData: hasMoreData)
    }
    
    private func handleFailure(with data: NetworkError<MarvelCharacterAPI>) {
        api.saveResponseIfNeeded(nil)
        delegate?.didFail(with: data)
    }
}
