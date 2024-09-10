//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import CoreData


/// Responsável por fazer a comunicação com o banco de dados e manipulação das entidades!
open class CoreDataManager {
    
    /// Nome do arquivo .xcdatamodeld -> Nome do banco de dados!
    open var dbModelName: String { "AppDataBase" }
    
    
    final public lazy var container: NSPersistentContainer = {
        // Cria o container a partir do modelo de dados configurado
        let container = NSPersistentContainer(name: dbModelName)
        
        // Carrega ele!
        container.loadPersistentStores {_, error in
            guard let error = error as NSError? else { return }
            print("[CoreData] Erro ao carregar container: \(error), \(error.userInfo)")
        }
        return container
    }()
    
    
    public init() {
        
    }
    
    
    final public var mainContext: NSManagedObjectContext {
        container.viewContext
    }
    
    final public func saveContext() throws {
        guard self.mainContext.hasChanges else { return }
        try? self.mainContext.save()
    }
}
