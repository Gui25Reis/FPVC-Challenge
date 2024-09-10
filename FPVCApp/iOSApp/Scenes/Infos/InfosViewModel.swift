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
import KingsDS


protocol InfosViewModelLogic {
    
    func didChangeFavoriteStatus() -> Bool
    
    func retrieveFavoriteStatus() -> Bool
    
    func setupTable()
    
    func shareInfos()
}



class InfosViewModel: InfosViewModelLogic, InfosTableHandlerDelegate {
    
    let characterInfos: MarvelCharacterData
    
    var accessRequest: KFAccessRequestLogic?
    var tableHandler: InfosTableHandler?
    
    weak var binding: InfosPresenter?
    
    
    init(data: MarvelCharacterData) {
        characterInfos = data
    }
    
    
    private func shareWithActivity(data: Any?) {
        guard let data else { return }
        let activityController = UIActivityViewController(
            activityItems: [data], applicationActivities: nil
        )
        
        binding?.show(controller: activityController)
    }
}


// MARK: - + InfosViewModelLogic
extension InfosViewModel {
    
    func didChangeFavoriteStatus() -> Bool {
        characterInfos.didChangeFavoriteStatus()
        FavoriteManager.shared.didChangeFavoriteStatus(data: characterInfos)
        return retrieveFavoriteStatus()
    }
    
    func shareInfos() {
        shareWithActivity(data: characterInfos.toShare)
    }
    
    func retrieveFavoriteStatus() -> Bool {
        characterInfos.isFavorited
    }
    
    func setupTable() {
        guard let table = binding?.screen.tableView else { return }
        tableHandler = InfosTableHandler(table: table, data: characterInfos)
        tableHandler?.delegate = self
    }
}


// MARK: - + InfosTableHandlerDelegate
extension InfosViewModel {
    
    func shareImage(_ image: KDSImage?) {
        accessRequest?.checkPermission(for: .gallery) { [weak self] response in
            guard let self else { return }
            
            guard let alert = response.alert else {
                self.shareWithActivity(data: image?.imageCreated)
                return
            }
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                self.shareWithActivity(data: image?.imageCreated)
            }
            alert.addAction(okAction)
            self.binding?.show(controller: alert)
        }
    }
}
