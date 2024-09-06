//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import KingsFoundation


final class MarvelCharacterAPI: MarvelAPI, APIHandler {
    
    typealias SuccessModel = MarvelCharactersModels.SuccessData
    typealias FailureModel = MarvelCharactersModels.FailureData
    
    
    override var endpointBase: String { "\(super.endpointBase)/characters" }
    
    var pagination = PaginationData()
    
    
    /* Construtores */
    override init() {
        super.init()
        addFixedParamters()
    }
    
    
    /* Encapsulamento */
    func addParameter(data: MarvelCharactersParameters) {
        otherParameters.updateValue(data, forKey: data.parameter)
    }
    
    func prepareForPagination() {
        let offSet = pagination.randomOffSet
        addParameter(data: .offset("\(offSet)"))
    }
    
    func saveResponseIfNeeded(_ data: SuccessModel) {
        updatePaginationInfo(with: data)
        cleanParameters()
    }
    
    
    /* Configurações */
    private func cleanParameters() {
        otherParameters.removeAll()
        addFixedParamters()
    }
    
    private func addFixedParamters() {
        addParameter(data: .limit("80"))
    }
    
    private func updatePaginationInfo(with data: SuccessModel) {
        pagination.limitePerRequest = (data.data?.limit).defaultValue
        pagination.available = (data.data?.total).defaultValue
        
        let offSet = data.data?.offset
        pagination.didAsked[offSet.defaultValue] = true
    }
}
