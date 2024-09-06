/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


/// Os tipos que estão de acordo com esse protocolo são usados em células costumizadas
/// tanto de uma table quanto de um collection.
public protocol KDSCustomComponent: AnyObject {
    
    /// Identificador
    static var identifier: String { get }
}


/// Os tipos que estão de acordo com esse protocolo são usados em células costumizadas
/// tanto de uma table quanto de um collection.
public protocol KDSCollectionComponent: KDSCustomComponent {
    
    static func register(at collection: KDSDataCollection)
}

public extension KDSCollectionComponent {
    
    static func register(at collection: KDSDataCollection) {
        collection.registerCell(for: Self.self)
    }
}



// MARK: - KDSTableCellType
public protocol KDSTableCellType: UITableViewCell, KDSCollectionComponent {
    
}


// MARK: - KDSCollectionCellType
public protocol KDSCollectionCellType: UICollectionViewCell, KDSCollectionComponent {
    
}


// MARK: - KDSCollectionReusableViewType
public protocol KDSCollectionReusableViewType: UICollectionReusableView, KDSCollectionComponent {
    
}
