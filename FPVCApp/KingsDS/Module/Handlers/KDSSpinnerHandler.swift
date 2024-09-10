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
import KingsFoundation


public protocol KDSSpinnerHandler: UIView {
    
    var loadingIndicator: UIActivityIndicatorView? { get set }
    
    /* Implementação Opcional */
    var canShowSpinner: Bool { get }
}


public extension KDSSpinnerHandler {
    
    var canShowSpinner: Bool {
        loadingIndicator.isNil && !bounds.isEmpty
    }
    
    @MainActor
    func showSpinner(style: LoadingSpinnerStyle = .medium) {
        loadingIndicator = {
            let spinner = UIActivityIndicatorView(style: style)
            spinner.color = .darkGray
            addSubview(spinner)
            spinner.centerAtSuperview()
            spinner.startAnimating()
            return spinner
        }()
    }
    
    @MainActor
    func showSpinnerIfCan(style: LoadingSpinnerStyle = .medium) {
        guard canShowSpinner else { return }
        showSpinner(style: style)
    }
    
    @MainActor
    func removeSpinner(forced: Bool = false) {
        guard loadingIndicator.isNotNil || forced else { return }
        
        loadingIndicator?.stopAnimating()
        loadingIndicator?.removeFromSuperview()
        loadingIndicator = nil
    }
}
