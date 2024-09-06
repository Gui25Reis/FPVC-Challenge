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

public struct KDSEmptyViewVM {
    public var image: KDSImage?
    public var title: String
    public var message: String
    public var buttomVM: KDSButtonViewModel?
    
    
    var hasImage: Bool { image.isNotNil }
    
    var hasButton: Bool { buttomVM.isNotNil }
    
    
    public init(image: KDSImage? = nil, title: String, message: String, buttomVM: KDSButtonViewModel? = nil) {
        self.image = image
        self.title = title
        self.message = message
        self.buttomVM = buttomVM
    }
}
