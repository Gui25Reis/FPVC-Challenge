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


public protocol KDSDataCollection: AnyObject, KDSDataCollectionType {
    
    func registerCell<T: KDSCustomComponent>(for cell: T.Type)
    
    func reusableCell<T: KDSCustomComponent>(as cell: T.Type, for indexPath: IndexPath?) -> T?
    
    func checkIfCellIsRegistered(id: String) -> Bool
    
    func updateData()
}

public extension KDSDataCollection {
    
    @MainActor
    func updateData() {
        reloadData()
        layoutIfNeeded()
    }
}
