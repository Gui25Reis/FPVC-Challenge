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
import KingsStorage


class MarvelAPI {
    
    var endpointBase: String { "http://gateway.marvel.com/v1/public" }
    
    var storage: any StorageHadler = KeychainManager()
    
    var publicKey: String {
        (storage.retrieve(forKey: "marvelPublic") as? String).defaultValue
    }
    
    var privateKey: String {
        (storage.retrieve(forKey: "marvelPriv") as? String).defaultValue
    }
    
    var randomKey: String { Date.now.toString(with: .asset) }
    
    
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
