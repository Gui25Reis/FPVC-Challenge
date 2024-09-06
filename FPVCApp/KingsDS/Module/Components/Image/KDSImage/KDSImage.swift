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
import KingsFoundation


public class KDSImage {
    
    var imageCreated: UIImage?
    
    public var hasImage: Bool { imageCreated.isNotNil }
    
    
    // MARK: - Construtores
    public init() {
        
    }
    
    public init(asset: KDSAssetsType?) {
        guard let asset else { return }
        imageCreated = createImageFrom(asset: asset)
    }
    
    public init(viewModel: KDSImageViewModel?) {
        guard let viewModel else { return }
        imageCreated = createImageFrom(viewModel: viewModel)
    }
    
    public init(file: KDSFile) {
        imageCreated = createImageFrom(file: file)
    }
    
    public init(gifData data: Data) {
        let gifMaker = KDSGifMaker(data: data)
        imageCreated = gifMaker.makeImage()
    }
    
    public init(data: Data) {
        imageCreated = UIImage(data: data)
    }
    
    
    // MARK: - Encapsulamento
    public func createIfEmpty(asset: KDSAssetsType) {
        guard hasImage == false else { return }
        imageCreated = createImageFrom(asset: asset)
    }
    
    
    // MARK: - Criações
    private func createImageFrom(file: KDSFile) -> UIImage? {
        return switch file.type {
        case .system:
            UIImage(systemName: file.name)
        default:
            UIImage(named: file.name, in: file.bundle, with: nil)
        }
    }
    
    private func createImageFrom(viewModel: KDSImageViewModel) -> UIImage? {
        let file = viewModel.asset.file
        let image = createImageFrom(file: file)
        
        if let color = viewModel.color {
            image?.withTintColor(color, renderingMode: viewModel.mode)
        } else {
            image?.withRenderingMode(viewModel.mode)
        }
        return image
    }
    
    private func createImageFrom(asset: KDSAssetsType) -> UIImage? {
        let imageVM = KDSImageViewModel(asset: asset)
        return createImageFrom(viewModel: imageVM)
    }
}
