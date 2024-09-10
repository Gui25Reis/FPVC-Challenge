//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

@testable import FPVCApp
import XCTest
import KingsDS


class HomeViewModelMock {
    var didCallTryNewFetchAgain = false
    var didCallCreateSearchController = false
    var didCallFetchMoreData = false
    var didCallFetchData = false
    
    var controllerToReturn = KDSSearchController()
}


extension HomeViewModelMock: HomeViewModelLogic {
    func tryNewFetchAgain() {
        didCallTryNewFetchAgain = true
    }
    
    func createSearchController() -> KDSSearchController {
        didCallCreateSearchController = true
        return controllerToReturn
    }
    
    func fetchMoreData() {
        didCallFetchMoreData = true
    }
    
    func fetchData() {
        didCallFetchData = true
    }
}


extension HomeViewModelMock: MockProtocol {
    
    func clearVariables() {
        didCallTryNewFetchAgain = false
        didCallCreateSearchController = false
        didCallFetchMoreData = false
        didCallFetchData = false
    }
}
