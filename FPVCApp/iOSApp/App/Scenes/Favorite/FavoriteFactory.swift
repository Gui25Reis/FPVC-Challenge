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


enum FavoriteFactory {
    
    static func makeController() -> UIViewController {
        let controller = FavoriteController()
        
        let viewModel = FavoriteViewModel()
        viewModel.notificator = KFNotificator(provider: NotificationCenter.default)
        viewModel.binding = controller
        
        controller.viewModel = viewModel
        return controller
    }
}
