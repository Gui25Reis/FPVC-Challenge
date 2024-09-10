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
import KingsStorage
import KingsFoundation
import KingsDS


class FavoriteManager {
    
    static let shared = FavoriteManager()
    
    // Managers
    var persistent = MarvelDBManager.shared
    var imagesStorage = ImagesStorage(directoryType: .documentDirectory)
    
    // Caches
    var allDataFromDB = [Int:MarvelCharacterData]()
    var unsavedData = NSCacheType<MarvelCharacterData>()
    
    
    // Handlers
    var dispatcher = KFDispatcherQueue(provider: DispatchQueue.global(qos: .background))
    var notificator = KFNotificator(provider: NotificationCenter.default)
    
    // Data
    var unsavedChanges = Set<Int>()
    var hasChanges: Bool { !unsavedChanges.isEmpty }
    
    var isDatabaseEmpty = false
    var lastDataRetrieved: [MarvelCharacterData]?
    
    
    // MARK: - Métodos
    func didChangeFavoriteStatus(data: MarvelCharacterData) {
        unsavedChanges.insert(data.id)
        unsavedData.save(data, forKey: data.id.toString)
    }
    
    func checkIfIsFavorited(id: Int) -> MarvelCharacterData? {
        getAllDataIfNeeded()
        let data = allDataFromDB[id]
        let isFavorited = data?.isFavorited == true
        return isFavorited ? data : nil
    }
    
    func getFavoritedCharacters() -> [MarvelCharacterData] {
        if let lastDataRetrieved, hasChanges == false {
            return lastDataRetrieved
        }
        
        let favoritedData = persistent.retrieveAll()
        favoritedData.forEach {
            let imageSaved = imagesStorage.retrieve(forKey: $0.image.imageName)
            $0.image.image = KDSImage(image: imageSaved)
        }
        lastDataRetrieved = favoritedData
        return favoritedData
    }
    
    func updateDataFromRequest(_ dataReceived: inout [MarvelCharacterData]) {
        for data in dataReceived {
            let id = data.id
            guard let favData = checkIfIsFavorited(id: id) else { continue }
            
            data.isFavorited = true
            data.favoritedDate = favData.favoritedDate
            
            let imageDownloaded = imagesStorage.retrieve(forKey: data.image.imageName)
            if let imageDownloaded {
                data.image.image = KDSImage(image: imageDownloaded)
            }
        }
    }
    
    func saveChangesIfNeeded() {
        guard !unsavedChanges.isEmpty else { return }
        
        for id in unsavedChanges {
            let key = id.toString
            let data = unsavedData.retrieve(forKey: key)
            
            guard let data else { continue }
            
            updateChanges(for: data)
            unsavedData.delete(forKey: key)
        }
        
        unsavedChanges.removeAll()
        
        dispatcher.async {
            self.persistent.saveChanges()
            self.getAllDataIfNeeded(isNeeded: true)
            self.notificator.sendEvent(forKey: .coreDateSaving)
        }
    }
    
    
    private func updateChanges(for data: MarvelCharacterData) {
        let key = data.id.toString
        guard data.isFavorited else {
            // Removendo
            imagesStorage.delete(forKey: key)
            persistent.delete(forKey: key)
            return
        }
        
        // Adicionado
        persistent.save(data, forKey: key)
        if let image = data.image.image?.imageCreated {
            imagesStorage.save(image, forKey: data.image.imageName)
        }
    }
    
    private func getAllDataIfNeeded(isNeeded: Bool = false) {
        guard allDataFromDB.isEmpty || isNeeded else { return }
        
        if isDatabaseEmpty && !isNeeded { return }
        
        let dataSaveOnCoreDate = persistent.retrieveAll()
        dataSaveOnCoreDate.forEach {
            let imageSaved = imagesStorage.retrieve(forKey: $0.image.imageName)
            $0.image.image = KDSImage(image: imageSaved)
            allDataFromDB[$0.id] = $0
        }
        
        isDatabaseEmpty = dataSaveOnCoreDate.isEmpty
        lastDataRetrieved = dataSaveOnCoreDate
    }
}
