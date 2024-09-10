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
import KingsStorage
import KingsDS
import KingsNetwork


public protocol ImagesDownloaderDelegate: AnyObject {
    
    func didDownloadImageSuccessfully(image: KDSImage, _ dict: [String: Any])
    
    func didDownloadImageFailure(error: ImagesDownloaderErrors, _ dict: [String: Any])
}


public protocol ImagesDownloaderLogic {
    
    func downloadFromWeb(imageURL: String?, dict: [String: Any]) -> KDSImage?
    
    func buildImage(with data: Data?, _ dict: [String: Any])
}


open class ImagesDownloader: ImagesDownloaderLogic {
        
    public weak var delegate: ImagesDownloaderDelegate?
    
    var dispatcher = KFDispatcherQueue(provider: DispatchQueue.global(qos: .background))
    
    var network = NetworkHandler<ImageAPI>()
    
    var cache = NSCacheType<KDSImage>()
    
    
    private func donwload(imageURL: String?, _ dict: [String: Any] = [:]) {
        guard let imageURL else { return finishWith(error: .badURL, dict) }
        
        var dict = dict
        dict["isGif"] = imageURL.contains(".gif")
        
        let api = ImageAPI(imageURL: imageURL)
        try? network.makeRequest(for: api) { [weak self] result in
            var data: Data? {
                return switch result {
                case .success(let result):
                    result.data
                case .failure(let result):
                    result.result.data
                }
            }
            
            self?.buildImage(with: data, dict)
        }
    }
    
    
    private func finishWith(image: KDSImage, _ dict: [String: Any]) {
        delegate?.didDownloadImageSuccessfully(image: image, dict)
    }
    
    private func finishWith(error: ImagesDownloaderErrors, _ dict: [String: Any]) {
        delegate?.didDownloadImageFailure(error: error, dict)
    }
    
    
    // MARK: Cache
    private func saveOnCache(_ image: KDSImage, _ dict: [String: Any]) {
        let fileName = dict["fileName"] as? String
        guard let fileName else { return }
        cache.save(image, forKey: fileName)
    }
    
    private func retrieveFromCacheIfExistis(_ dict: [String: Any]) -> KDSImage? {
        let fileName = dict["fileName"] as? String
        guard let fileName else { return nil }
        return cache.retrieve(forKey: fileName)
    }
}


// MARK: - + ImagesDownloaderLogic
public extension ImagesDownloader {
    
    func downloadFromWeb(imageURL: String?, dict: [String: Any]) -> KDSImage? {
        let imageCached = retrieveFromCacheIfExistis(dict)
        
        if let imageCached {
            return imageCached
        }
        
        defer { donwload(imageURL: imageURL, dict) }
        return nil
    }
    
    func buildImage(with data: Data?, _ dict: [String: Any]) {
        guard let data else {
            return finishWith(error: .noData, dict)
        }
        
        let isGif = (dict["isGif"] as? Bool).isTrue
        
        dispatcher.async {
            let image = isGif ? KDSImage(gifData: data) : KDSImage(data: data)
            
            guard image.hasImage else {
                return self.finishWith(error: .badCreation, dict)
            }
            
            self.saveOnCache(image, dict)
            self.finishWith(image: image, dict)
        }
    }
}
