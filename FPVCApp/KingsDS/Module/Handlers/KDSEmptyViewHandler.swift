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


public protocol KDSEmptyViewHandler: UIView {
    
    var emptyView: KDSEmptyView { get set }
    
    var emptyViewVM: KDSEmptyViewVM { get set }
    
    
    /* Métodos opcionais */
    func showEmptyView()
    
    func hideEmptyView()
}


public extension KDSEmptyViewHandler {
    
    func showEmptyView() {
        KDSMainDispatcher.onMainThread {
            self.emptyView.hasSuperview
            ? self.emptyView.isHidden = false
            : self.addSubview(self.emptyView)
        }
    }
    
    func hideEmptyView() {
        self.emptyView.isHidden = true
    }
}
