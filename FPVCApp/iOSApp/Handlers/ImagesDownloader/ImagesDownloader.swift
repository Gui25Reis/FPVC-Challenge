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


protocol ImagesDownloaderDelegate: AnyObject {
    
    func didDownloadImageSuccessfully(image: KDSImage, _ dict: [String: Any])
    
    func didDownloadImageFailure(error: ImagesDownloaderErrors, _ dict: [String: Any])
}


class ImagesDownloader {
    
    weak var delegate: ImagesDownloaderDelegate?
    
    let dispatcher = KFDispatcherQueue(provider: DispatchQueue.global(qos: .background))
    
    let network = NetworkHandler<ImageAPI>()
    
    let cache = NSCacheType<KDSImage>()
    
    
    func downloadLocally(imageURL: String?, dict: [String: Any] = [:]) {
        dispatcher.async {
            guard let imageURL = imageURL?.asURL else {
                return self.finishWith(error: .badURL, dict)
            }
            
            let data = try? Data(contentsOf: imageURL)
            self.buildImage(with: data, dict: dict)
        }
    }
    
    func downloadFromWeb(imageURL: String?, dict: [String: Any] = [:]) -> KDSImage? {
        let imageCached = retrieveFromCacheIfExistis(dict)
        
        if let imageCached {
//            print("[ImagesDownloader] Imagem cacheada!")
            return imageCached
        }
        
        defer { donwload(imageURL: imageURL, dict) }
        return nil
    }
    
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
            
            self?.buildImage(with: data, dict: dict)
        }
    }
    
    func buildImage(with data: Data?, dict: [String: Any] = [:]) {
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
    
    func finishWith(error: ImagesDownloaderErrors, _ dict: [String: Any]) {
//        print("[ImagesDownloader] Erro no download da imagem: \(error.desciption)")
        delegate?.didDownloadImageFailure(error: error, dict)
    }
    
    func finishWith(image: KDSImage, _ dict: [String: Any]) {
//        print("[ImagesDownloader] Success no download da imagem!")
        delegate?.didDownloadImageSuccessfully(image: image, dict)
    }
    
    
    // MARK: Cache
    func saveOnCache(_ image: KDSImage, _ dict: [String: Any]) {
        let fileName = dict["fileName"] as? String
        guard let fileName else { return }
        cache.save(image, forKey: fileName)
    }
    
    func retrieveFromCacheIfExistis(_ dict: [String: Any]) -> KDSImage? {
        let fileName = dict["fileName"] as? String
        guard let fileName else { return nil }
        return cache.retrieve(forKey: fileName)
    }
}
