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


open class APIRequest {
    
    
    public let endpointBase: String
    
    private(set) var endpoint: String
    
    
    private var hasParameter = false
    
    private var parameterKey: String { hasParameter ? "&" : "?" }
    
    
    open var httpMathod: APIHTTPMethod = .get
    
    
    /* Construtores */
    public init(endpointBase: String) {
        self.endpointBase = endpointBase
        endpoint = endpointBase
    }
    
    
    /* Métodos */
    open func addParameter(_ key: String, withData data: String) {
        defer { hasParameter = true }
        endpoint = "\(endpoint)\(parameterKey)\(key)=\(data)"
    }
    
    func build() throws -> URLRequest {
        print("endpoint criado: \(endpoint)")
        
        guard let url = URL(string: endpoint) else {
            throw APIErrors.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMathod.name
        
        return request
    }
}
