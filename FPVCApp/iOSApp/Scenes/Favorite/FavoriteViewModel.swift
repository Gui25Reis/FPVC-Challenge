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


protocol FavoriteViewModelLogic {
    
    func setupCollection(_ collection: KDSCollection)
    
    func updateTableData()
}


class FavoriteViewModel: FavoriteViewModelLogic, FavoriteCollectionHandlerDelegate {
    
    var binding: FavoritePresenter?
    
    var collectionHandler: FavoriteCollectionHandler?
    var notificator: KFNotificator?
    
    
    deinit {
        notificator?.unregister(self, key: .coreDateSaving)
    }
}


// MARK: - + FavoriteViewModelLogic
extension FavoriteViewModel {
    
    func setupCollection(_ collection: KDSCollection) {
        collectionHandler = FavoriteCollectionHandler(collection: collection)
        collectionHandler?.delegate = self
        updateTableData()
        notificator?.register(self, action: #selector(updateTableData), key: .coreDateSaving)
    }
    
    @objc func updateTableData() {
        let newData = FavoriteManager.shared.getFavoritedCharacters()
        collectionHandler?.newData(newData)
    }
}


// MARK: - + FavoriteCollectionHandlerDelegate
extension FavoriteViewModel {
    
    func routeToInfos(with data: MarvelCharacterData) {
        let controller = InfosFactory.makeControler(data: data)
        binding?.route(to: controller)
    }
}
