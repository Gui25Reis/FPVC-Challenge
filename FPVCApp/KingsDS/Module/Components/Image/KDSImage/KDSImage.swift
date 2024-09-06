//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import UIKit


public class KDSImage {
    
    var imageCreated: UIImage?
    
    
    /* Construtores */
    public init() {
        
    }
    
    public convenience init(asset: KDSAssetsType?) {
        guard let asset else { self.init(); return }
        
        let imageVM = KDSImageViewModel(asset: asset)
        self.init(viewModel: imageVM)
    }
    
    
    public convenience init(viewModel: KDSImageViewModel?) {
        guard let viewModel else { self.init(); return }
        
        let file = viewModel.asset.file
        self.init(file: file)
        
        let newImage = imageCreated
        
        if let color = viewModel.color {
            newImage?.withTintColor(color, renderingMode: viewModel.mode)
        } else {
            newImage?.withRenderingMode(viewModel.mode)
        }
        
        imageCreated = newImage
    }
    
    
    public init(file: KDSFile) {
        let image = switch file.type {
        case .system:
            UIImage(systemName: file.name)
        default:
            UIImage(named: file.name, in: file.bundle, with: nil)
        }
        
        imageCreated = image
    }
    

    public init(gifData data: Data) {
        let gifMaker = KDSGifMaker(data: data)
        imageCreated = gifMaker.makeImage()
    }
}
