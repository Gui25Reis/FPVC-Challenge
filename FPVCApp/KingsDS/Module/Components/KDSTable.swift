/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


/// Table costumizada
open class KDSTable: UITableView, KDSComponent, KDSDataCollection {
    
    /* MARK: - Construtor */
    
    public init(style: UITableView.Style = .insetGrouped) {
        super.init(frame: .zero, style: style)
        initialSetup()
    }
    
    required public init?(coder: NSCoder) { return nil }
    
    
    
    /* MARK: - KDSDataCollection */
    
    final public func registerCell<T>(for cell: T.Type) where T : KDSCustomComponent {
        guard let cell = cell as? KDSTableCellType.Type else { return }
        register(cell, forCellReuseIdentifier: cell.identifier)
    }
    
    final public func reusableCell<T: KDSCustomComponent>(as cell: T.Type, for indexPath: IndexPath?) -> T? {
        guard checkIfCellIsRegistered(id: cell.identifier) else { return nil }
        if let indexPath {
            return dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as? T
        } else {
            return dequeueReusableCell(withIdentifier: cell.identifier) as? T
        }
        
    }
    
    final public func checkIfCellIsRegistered(id: String) -> Bool {
        let registeredCells = value(forKey: "_cellClassDict") as? [String: Any]
        return registeredCells?[id] != nil
    }
    

//    /// Configura o handler da tabela
//    /// - Parameter handler: handler de acordo com o protocolo
//    public func setupTableHadler(with handler: TableHandler) {
//        self.dataSource = handler
//        self.delegate = handler
//    }

        
    /* MARK: - KDSComponent */
    
    /// Configura a view
    final public func initialSetup() {
        activateConstraints()
        
        clipsToBounds = true
        layer.masksToBounds = true
    }
}
