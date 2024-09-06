//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import KingsCryptor
import KingsFoundation


class MarvelAPI {
    
    var endpointBase: String { "http://gateway.marvel.com/v1/public" }
    
    
    var publicKey: String { "124db90affdebfdb6cbd55a90ffcb4fd" }
    
    var privateKey: String { "c5708bd6e9d89b845048ebc1d0e78a9872594cd8" }
    
    var randomKey: String { "kings" }
    
    
    var cryptor: KingsCryptorManager = KingsCryptor()
    
    
    public var otherParameters = [String: MarvelParameters]()
    
    
    final func createRequest() throws -> APIRequest {
        let request = APIRequest(endpointBase: endpointBase)
        request.httpMathod = .get
        
        try appendCoreParameters(at: request)
        appendOtherParameters(at: request)
        
        return request
    }
    
    
    /* Parâmetros */
    private func appendCoreParameters(at request: APIRequest) throws {
        let dataToEncrypt = "\(randomKey)\(privateKey)\(publicKey)"
        let hash = try cryptor.encrypt(data: dataToEncrypt, type: .md5)
        
        request.addParameter("ts", withData: randomKey)
        request.addParameter("apikey", withData: publicKey)
        request.addParameter("hash", withData: hash)
    }
    
    private func appendOtherParameters(at request: APIRequest) {
        guard otherParameters.isEmpty == false else { return }
        
        otherParameters.values.forEach {
            request.addParameter($0.parameter, withData: $0.value)
        }
    }
}
