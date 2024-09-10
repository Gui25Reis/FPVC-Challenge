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


public protocol KDSSearchDelegate: KDSSearchLifeCycle {
    
    func searchWith(data text: String)
    
    func searchCanceled()
}



// MARK: - KDSSearchLifeCycle
public protocol KDSSearchLifeCycle: AnyObject {
    
    func searchDidTrigger(_ searchController: KDSSearchController)
    
    func willPresentSearch(_ searchController: KDSSearchController)
    
    func didPresentSearch(_ searchController: KDSSearchController)
    
    func willDismissSearch(_ searchController: KDSSearchController)
    
    func didDismissSearch(_ searchController: KDSSearchController)
}


/* Implementação Opcional */
public extension KDSSearchLifeCycle {
    
    func searchDidTrigger(_ searchController: KDSSearchController) { }
    
    func willPresentSearch(_ searchController: KDSSearchController) { }
    
    func didPresentSearch(_ searchController: KDSSearchController) { }
    
    func willDismissSearch(_ searchController: KDSSearchController) { }
    
    func didDismissSearch(_ searchController: KDSSearchController) { }
}
