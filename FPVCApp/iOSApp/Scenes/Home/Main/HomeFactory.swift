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
import KingsDS


enum HomeFactory {
    
    static func makeController() -> UIViewController {
        let controller = HomeViewController()
        
        let dispatcher = KFDispatcherQueue(provider: DispatchQueue.main)
        controller.dispatcher = dispatcher
        
        let viewModel = HomeViewModel()
        viewModel.mainBinding = controller
        
        viewModel.mainWorker = makeWorker(delegate: viewModel)
        viewModel.searchWorker = makeWorker(delegate: viewModel)
        
        controller.viewModel = viewModel
        
        return controller
    }
    
    static func makeCollectionHandler(_ collection: KDSCollection, delegate: HomeCollectionHandlerDelegate) -> HomeCollectionHandler {
        
        let handler = HomeCollectionHandler(collection: collection)
        handler.delegate = delegate
        
        return handler
    }
    
    static func makeWorker(delegate: MarvelCharacterWorkerDelegate) -> MarvelCharacterWorker {
        let worker = MarvelCharacterWorker()
        worker.delegate = delegate
        return worker
    }
}
