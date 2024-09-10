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
import KingsFoundation


final public class NetworkHandler<API: APIHandler> {
    
    public typealias Response = Result<API.SuccessModel, NetworkAPIError>
    
    public typealias NetworkAPIError = NetworkError<API>
    
    var decoder = JSONDecoder()
    var dispatcher = KFDispatcherQueue(provider: DispatchQueue.main)
    
    let session: URLSession
    
    
    /* Construtores */
    public init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    public func makeRequest(for api: any APIHandler, _ completion: @escaping(Response) -> Void) throws {
        let apiRequest = try api.createRequest()
        let request = try apiRequest.build()
        
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let self else { return }
            
            let result = SessionReturn(data, response, error)
            
            let finalResponse = self.handleResponse(result)
            completion(finalResponse)
        }
        
        task.resume()
    }
    
    
    /* Configurações */
    private func handleResponse(_ response: SessionReturn) -> Response {
        guard let data = response.data else {
            return .failure(NetworkAPIError(nil, response))
        }
        
//        showJsonDataIfPossible(with: data)
        
        do {
            let successModel = try makeSuccessModel(with: data)
            return .success(successModel)
        } catch {
            let failureModel = try? makeFailureModel(with: data)
            return .failure(NetworkAPIError(failureModel, response))
        }
        
    }
    
    private func makeSuccessModel(with data: Data) throws -> API.SuccessModel {
        let noModel: API.SuccessModel? = createNoModelIfPossible(with: data)
        return try noModel ?? decoder.decode(API.SuccessModel.self, from: data)
    }
    
    private func makeFailureModel(with data: Data) throws -> API.FailureModel {
        let noModel: API.FailureModel? = createNoModelIfPossible(with: data)
        return try noModel ?? decoder.decode(API.FailureModel.self, from: data)
    }
    
    private func createNoModelIfPossible<T: Codable>(with data: Data) -> T? {
        let noModelType = T.self as? NoModel.Type
        let model = noModelType?.init(data: data) as? T
        return model
    }
    
    
    private func showJsonDataIfPossible(with data: Data) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            
            let jsonDict = json as? [String: Any]
            
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict ?? [:], options: .prettyPrinted)
            
            let jsonString = String(data: jsonData, encoding: .utf8)
            
            print("[Network] Json:")
            print(jsonString ?? "Sem dados!")
        } catch /* (error) */  {
//            print("[Network] Erro ao mostrar JSON: \(error.localizedDescription)")
        }
    }
}
