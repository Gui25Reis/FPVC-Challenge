//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import KingsDS


struct MarvelCharacterImage: CustomStringConvertible {
    var url: String?
    var imageName: String
    var image: KDSImage?
    
    
    // MARK: - Construtores
    init(url: String? = nil) {
        self.url = url
        
        let imageNameFromUrl = url?.components(separatedBy: "/").last
        imageName = imageNameFromUrl.defaultValue
    }
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
    
    /* CustomStringConvertible */
    var description: String {
        """
        MarvelCharacterImage {
                url: \(url.string)
                imageName: \(imageName)
                image: \(image.isNotNil)
            }
        """
    }
}
