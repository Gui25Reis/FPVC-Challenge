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


typealias MarvelCharacterDataUI = (title: String, data: String)

class MarvelCharacterData: CustomStringConvertible {
    let id: Int
    let name: String
    let infos: MarvelCharacterDataUI
    let modified: String?
    
    var image: MarvelCharacterImage
    var isFavorited: Bool = false
    var favoritedDate: String = ""
    
    let comics: MarvelCharacterDataUI
    let series: MarvelCharacterDataUI
    let stories: MarvelCharacterDataUI
    let events: MarvelCharacterDataUI
    
    
    /// Texto para compartilhamento!
    var toShare: String {
        """
        Olha só esse personagens (\(id)):
        Nome: \(name)
        Descrição: \(infos.data)
        """
    }

    
    // MARK: - Construtores
    init(id: Int, name: String, infos: String?, modified: String?, imageURL: String?, comics: Int?, series: Int?, stories: Int?, events: Int?) {
        self.id = id
        self.name = name
        
        let infoData = infos.hasData ? infos.defaultValue : "Descrição indisponível."
        self.infos = ("Descrição", infoData)
        
        self.modified = modified
        self.image = MarvelCharacterImage(url: imageURL)
        self.comics = ("Comics", "\(comics.defaultValue)")
        self.series = ("Series", "\(series.defaultValue)")
        self.stories = ("Stories", "\(stories.defaultValue)")
        self.events = ("Events", "\(events.defaultValue)")
    }
    
    
    convenience init?(from data: MarvelCharactersModels.CharacterInfos) {
        let id = data.id
        let name = data.name
        
        guard let id, let name else { return nil }
        
        self.init(
            id: id,
            name: name,
            infos: data.description,
            modified: data.modified,
            imageURL: data.thumbnail?.imageUrl,
            comics: data.comics?.available,
            series: data.series?.available,
            stories: data.stories?.available,
            events: data.events?.available
        )
    }
    
    
    init(dbModel: MDBCharacter) {
        id = dbModel.dataId.toInt
        name = dbModel.name
        
        infos = ("Descrição", dbModel.infos)
        
        modified = dbModel.modified
        image = MarvelCharacterImage(imageName: dbModel.image)
        comics = ("Comics", dbModel.comics)
        series = ("Series", dbModel.series)
        stories = ("Stories", dbModel.stories)
        events = ("Events", dbModel.events)
        
        isFavorited = true
        favoritedDate = dbModel.dateFavorited
    }
    
    func didChangeFavoriteStatus(to status: Bool? = nil) {
        if let status {
            isFavorited = status
        } else {
            isFavorited.toggle()
        }
        
        favoritedDate = ""
        
        guard isFavorited else { return }
        
        let now = Date.now
        favoritedDate = now.toString(with: .completeWritten)
        print("[MarvelCharacterData] \(#function) | Data: \(favoritedDate)")
    }
    
    
    // MARK: - CustomStringConvertible
    var description: String {
        """
        MarvelCharacterData {
            id: \(id)
            name: \(name)
            description: \(infos.data)
            modified: \(modified.string)
            image: \(image)
            favoritedDate: \(favoritedDate)
            isFavorited: \(isFavorited)
            comics: \(comics.data)
            series: \(series.data)
            stories: \(stories.data)
            events: \(events.data)
        }
        """
    }
    
    
    // MARK: - Encapsulamento
    func retriveAppearanceData(forRow row: Int) -> MarvelCharacterDataUI {
        return switch row {
        case 0: comics
        case 1: series
        case 2: events
        default: stories
        }
    }
}
