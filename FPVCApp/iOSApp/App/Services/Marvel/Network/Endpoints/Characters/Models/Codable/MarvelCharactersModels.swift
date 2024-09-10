//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

enum MarvelCharactersModels {
    
    // MARK: - FailureData
    struct FailureData: Codable {
        let code: Int
        let status: String
    }
    
    // MARK: - SuccessData
    struct SuccessData: Codable {
        let code: Int?
        let status: String?
        let copyright: String?
//        let attributionText: String?
//        let attributionHTML: String?
//        let etag: String?
        let data: CharacterContainer?
    }

    
    // MARK: - CharacterData
    struct CharacterContainer: Codable {
        let offset: Int?
        let limit: Int?
        let total: Int?
        let count: Int?
        let results: [CharacterInfos]?
    }

    
    // MARK: - CharacterInfos
    struct CharacterInfos: Codable {
        let id: Int?
        let name: String?
        let description: String?
        let modified: String?
        let thumbnail: CharacterImage?
        let resourceURI: String?
        let comics: CharacterCollection?
        let series: CharacterCollection?
        let stories: CharacterCollection?
        let events: CharacterCollection?
        let urls: [CharacterURL]?
    }

    
    // MARK: - CharacterCollection
    struct CharacterCollection: Codable {
        let available: Int?
        let collectionURI: String?
        let items: [CharacterCollectionItem]?
        let returned: Int?
    }

    
    // MARK: - CharacterCollectionItem
    struct CharacterCollectionItem: Codable {
        let resourceURI: String?
        let name: String?
        let type: String?
    }

    
    // MARK: - CharacterImage
    struct CharacterImage: Codable {
        let path: String?
        let `extension`: String?
        
        var imageUrl: String {
            "\(path.defaultValue).\(`extension`.defaultValue)"
        }
    }

    
    // MARK: - URLElement
    struct CharacterURL: Codable {
        let type: String?
        let url: String?
    }
}
