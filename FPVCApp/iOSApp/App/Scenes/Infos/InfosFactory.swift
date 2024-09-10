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


enum InfosFactory {
    
    static func makeControler(data: MarvelCharacterData) -> UIViewController {
        let viewModel = InfosViewModel(data: data)
        
        let controller = InfosController(viewModel: viewModel)
        controller.dispatcher = KFDispatcherQueue(provider: DispatchQueue.main)
        
        viewModel.binding = controller
        viewModel.accessRequest = KFAccessRequest.shared
        
        return controller
    }
}
