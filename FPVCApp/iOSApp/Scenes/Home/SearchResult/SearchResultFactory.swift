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

enum SearchResultFactory {
    
    static func makeController(delegate: HomeCollectionHandlerDelegate) -> SearchResultPresenter {
        
        let controller = SearchResultController()
        
        let handler = HomeFactory.makeCollectionHandler(
            controller.screen.collection,
            delegate: delegate
        )
        controller.collectionHandler = handler
        
        return controller
    }
}
