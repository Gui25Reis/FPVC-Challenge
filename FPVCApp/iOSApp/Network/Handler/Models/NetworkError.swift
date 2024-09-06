//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import Foundation


public struct NetworkError<API: APIHandler>: Error {
    public let decoded: API.FailureModel?
    public let result: SessionReturn
    
    init(_ decoded: API.FailureModel? = nil, _ result: SessionReturn) {
        self.decoded = decoded
        self.result = result
    }
}
