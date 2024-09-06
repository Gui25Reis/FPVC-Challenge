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


struct MarvelCharacterData: CustomStringConvertible {
    
    let id: Int
    let name: String
    let infos: String?
    let modified: String?
    
    let image: MarvelCharacterImage
    var hasDownloaded: Bool = false
    
    let comics: Int?
    let series: Int?
    let stories: Int?
    let events: Int?

    
    /* Construtores */
    init(id: Int, name: String, infos: String?, modified: String?, imageURL: String?, comics: Int?, series: Int?, stories: Int?, events: Int?) {
        self.id = id
        self.name = name
        self.infos = infos
        self.modified = modified
        self.image = MarvelCharacterImage(url: imageURL, fileNameFromId: id)
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
    }
    
    
    init?(from data: MarvelCharactersModels.CharacterInfos) {
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
    
    var description: String {
        """
        MarvelCharacterData {
            id: \(id)
            name: \(name)
            description: \(infos.string)
            modified: \(modified.string)
            image: \(image)
            hasDownloaded: \(hasDownloaded)
            comics: \(comics.string)
            series: \(series.string)
            stories: \(stories.string)
            events: \(events.string)
        }
        """
    }
}
