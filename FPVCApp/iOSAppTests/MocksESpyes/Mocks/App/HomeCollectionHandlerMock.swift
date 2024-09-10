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


class HomeCollectionHandlerMock {
    
    var didAccessCanLoadMoreData = false
    var didSetCanLoadMoreData = false
    
    var didCallCleanData = false
    var didCallNewData = false
    var didCallUpdateLastSelectedCellIfNeeded = false
    
    var dataReceived: [MarvelCharacterData]?
    
    
    /* HomeCollectionHandlerLogic */
    var canLoadMoreDataMock = false
    
    var canLoadMoreData: Bool {
        get {
            didAccessCanLoadMoreData = true
            return canLoadMoreDataMock
        }
        set(newValue) {
            didSetCanLoadMoreData = true
            canLoadMoreDataMock = newValue
        }
    }
}


extension HomeCollectionHandlerMock: HomeCollectionHandlerLogic {
    
    func cleanData() {
        didCallCleanData = true
    }
    
    func newData(_ newData: [MarvelCharacterData]) {
        didCallNewData = true
        dataReceived = newData
    }
    
    func updateLastSelectedCellIfNeeded() {
        didCallUpdateLastSelectedCellIfNeeded = true
    }
}


extension HomeCollectionHandlerMock: MockProtocol {
    
    func clearVariables() {
        didAccessCanLoadMoreData = false
        
        didCallCleanData = false
        didCallNewData = false
        didCallUpdateLastSelectedCellIfNeeded = false
        
        dataReceived = nil
    }
}
