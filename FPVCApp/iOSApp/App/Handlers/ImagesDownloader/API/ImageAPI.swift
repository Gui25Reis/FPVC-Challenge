//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import KingsNetwork


typealias ImageModel = NoModelDefault


struct ImageAPI: APIHandler {

    typealias SuccessModel = ImageModel
    typealias FailureModel = ImageModel
    
    var imageURL: String
    
    init(imageURL: String) {
        self.imageURL = imageURL
    }
    
    func createRequest() throws -> APIRequest {
        APIRequest(endpointBase: imageURL)
    }
}
