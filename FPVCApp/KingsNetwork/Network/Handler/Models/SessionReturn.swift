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


public struct SessionReturn {
    public let data: Data?
    public let respose: HTTPURLResponse?
    public let error: Error?
    
    public init(_ data: Data?, _ respose: URLResponse?, _ error: Error?) {
        self.data = data
        self.respose = respose as? HTTPURLResponse
        self.error = error
    }
}
