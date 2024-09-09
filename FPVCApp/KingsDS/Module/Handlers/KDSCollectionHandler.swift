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

/// Os tipos que estào de acordo com esse protocolo lidam com o funcionamento de uma collection,
/// tanto o delegate quanto o data source dela
public protocol KDSCollectionHandler: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout { 
    
    /// Registra uma célula
    /// - Parameter collection: collection que vai ser registrada
    func registerCell(at collection: KDSCollection)
    
    
    init(collection: KDSCollection)
}


public extension KDSCollectionHandler {
    
    /// Linka o data source e delegate na collection
    /// - Parameter collection: collection que vai ser linkada
    ///
    /// Essa função também faz o registro da célula
    func link(with collection: KDSCollection) {
        self.registerCell(at: collection)
        
        collection.delegate = self
        collection.dataSource = self
    }
}




/// Os tipos que estào de acordo com esse protocolo lidam com o funcionamento de uma collection,
/// tanto o delegate quanto o data source dela
public protocol KDSTableHandler: UITableViewDataSource, UITableViewDelegate {
    
    /// Registra uma célula
    /// - Parameter table: table que vai ser registrada
    func registerCell(at table: KDSTable)
    
    
    init(table: KDSTable)
}


public extension KDSTableHandler {
    
    /// Linka o data source e delegate na collection
    /// - Parameter collection: collection que vai ser linkada
    ///
    /// Essa função também faz o registro da célula
    func link(with table: KDSTable) {
        self.registerCell(at: table)
        
        table.delegate = self
        table.dataSource = self
    }
}
