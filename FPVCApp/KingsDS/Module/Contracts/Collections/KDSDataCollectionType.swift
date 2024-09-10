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


public protocol KDSDataCollectionType {
    
    func reloadData()
    
    func layoutIfNeeded()
}


// MARK: - UITableView + KDSDataCollectionType
extension UITableView: KDSDataCollectionType {
    /* Deixando de acordo com o protocolo */
}


// MARK: - UICollectionView + KDSDataCollectionType
extension UICollectionView: KDSDataCollectionType {
    /* Deixando de acordo com o protocolo */
}
