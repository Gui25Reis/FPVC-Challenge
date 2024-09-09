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
import CoreData


class MarvelDBManger: CoreDataManager, StorageHadler {
    
    typealias StorageData = MarvelCharacterData
    
    static let shared = MarvelDBManger()
    
    override var dbModelName: String { "MarvelDataBase" }
    
    
    // MARK: - StorageHadler
    func save(_ data: StorageData, forKey key: String) {
        let newData = MDBCharacter(context: mainContext)
        newData.populate(with: data)
    }
    
    func retrieve(forKey key: String) -> StorageData? {
        let request = MDBCharacter.fetchRequest(forId: key)
        let data = try? self.mainContext.fetch(request)
        
        guard let model = data?.first else { return nil }
        return MarvelCharacterData(dbModel: model)
    }
    
    func retrieveAll() -> [StorageData] {
        let request = MDBCharacter.fetchRequest()
        let data = try? self.mainContext.fetch(request)
        
        guard let data else { return [] }
        return data.map { MarvelCharacterData(dbModel: $0) }
    }
    
    func delete(forKey key: String) {
        let request = MDBCharacter.fetchRequest(forId: key)
        let data = try? self.mainContext.fetch(request)
        
        guard let model = data?.first else { return }
        mainContext.delete(model)
    }
    
    func cleanAll() {
        let request: NSFetchRequest<NSFetchRequestResult>  = MDBCharacter.fetchRequest()
        request.includesPropertyValues = false
                
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
                
        _ = try? self.container.persistentStoreCoordinator.execute(deleteRequest, with: mainContext)
    }
    
    func saveChanges() {
        try? self.saveContext()
    }
}
