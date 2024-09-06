//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//


struct MarvelCharacterImage: CustomStringConvertible {
    var url: String?
    var imageName: String
    var fileName: String
    
    
    init(url: String? = nil, fileNameFromId id: Int) {
        self.url = url
        
        let imageNameFromUrl = url?.components(separatedBy: "/").last
        imageName = imageNameFromUrl.defaultValue
        fileName = "\(id)"
    }
    
    
    /* CustomStringConvertible */
    var description: String {
        """
        MarvelCharacterImage {
                url: \(url.string)
                imageName: \(imageName)
                fileName: \(fileName)
            }
        """
    }
}
