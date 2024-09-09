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
    
    var cache = NSCacheType<MarvelCharacterData>()
    var persistent = MarvelDBManger.shared
    var imagesStorage = ImagesStorage(directoryType: .documentDirectory)
    
    var unsavedChanges = Set<Int>()
    
    var allData = [Int:MarvelCharacterData]()
    var isDatabaseEmpty = false
    
    let dispatcher = KFDispatcherQueue(provider: DispatchQueue.global(qos: .background))
    
    
    func didChangeFavoriteStatus(data: MarvelCharacterData) {
        unsavedChanges.insert(data.id)
        
        let cached = cache.retrieve(forKey: data.id.toString)
        if let cached {
            cached.isFavorited = data.isFavorited
        } else {
            cache.save(data, forKey: data.id.toString)
        }
    }
    
    func checkIfIsFavorited(id: Int) -> Bool {
        getAllDataIfNeeded()
        return allData[id]?.isFavorited == true
    }
    
    func getFavoritedCharacters() -> [MarvelCharacterData] {
        return persistent.retrieveAll()
    }
    
    func updateDataFromRequest(_ dataReceived: inout [MarvelCharacterData]) {
        for data in dataReceived {
            let id = data.id
            guard checkIfIsFavorited(id: id) else { continue }
            
            data.isFavorited = true
            
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
            let data = cache.retrieve(forKey: key)
            
            guard let data else { continue }
            
            updateChanges(for: data)
            cache.delete(forKey: key)
        }
        
        unsavedChanges.removeAll()
        dispatcher.async {
            self.persistent.saveChanges()
            self.getAllDataIfNeeded(isNeeded: true)
        }
    }
    
    
    private func updateChanges(for data: MarvelCharacterData) {
        let key = data.id.toString
        guard data.isFavorited else {
            imagesStorage.delete(forKey: key)
            persistent.delete(forKey: key)
            return
        }
        
        persistent.save(data, forKey: key)
        if let image = data.image.image?.imageCreated {
            imagesStorage.save(image, forKey: data.image.imageName)
        }
    }
    
    private func getAllDataIfNeeded(isNeeded: Bool = false) {
        guard allData.isEmpty || isNeeded else { return }
        
        if isDatabaseEmpty && !isNeeded { return }
        
        let dataSaveOnCoreDate = persistent.retrieveAll()
        dataSaveOnCoreDate.forEach { allData[$0.id] = $0 }
        isDatabaseEmpty = dataSaveOnCoreDate.isEmpty
    }
}
