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


protocol ImagesDownloaderDelegate: AnyObject {
    
    func didDownloadImageSuccessfully(image: UIImage, _ dict: [String: Any])
    
    func didDownloadImageFailure(error: ImagesDownloaderErrors, _ dict: [String: Any])
}


class ImagesDownloader {
    
    weak var delegate: ImagesDownloaderDelegate?
    
    let dispatcher = KFDispatcherQueue(provider: DispatchQueue.global(qos: .background))
    
    let network = NetworkHandler<ImageAPI>()
    
    let cache = NSCacheType<UIImage>()
    
    
    func downloadLocally(imageURL: String?, dict: [String: Any] = [:]) {
        dispatcher.async {
            guard let imageURL = imageURL?.asURL else {
                return self.finishWith(error: .badURL, dict)
            }
            
            let data = try? Data(contentsOf: imageURL)
            self.buildImage(with: data, dict: dict)
        }
    }
    
    func downloadFromWeb(imageURL: String?, dict: [String: Any] = [:]) -> UIImage? {
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
            let image = isGif
            ? UIImage.animatedImage(withGIFData: data) ?? UIImage(data: data)
            : UIImage(data: data)
            
            guard let image else {
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
    
    func finishWith(image: UIImage, _ dict: [String: Any]) {
//        print("[ImagesDownloader] Success no download da imagem!")
        delegate?.didDownloadImageSuccessfully(image: image, dict)
    }
    
    
    // MARK: Cache
    func saveOnCache(_ image: UIImage, _ dict: [String: Any]) {
        let fileName = dict["fileName"] as? String
        guard let fileName else { return }
        cache.save(image, forKey: fileName)
    }
    
    func retrieveFromCacheIfExistis(_ dict: [String: Any]) -> UIImage? {
        let fileName = dict["fileName"] as? String
        guard let fileName else { return nil }
        return cache.retrieve(forKey: fileName)
    }
}


extension UIImage {
    
    /// Cria uma UIImage animada a partir dos dados de um GIF
    static func animatedImage(withGIFData data: Data) -> UIImage? {
        print("Foi identificado que a imagem eh um gif!")
        
        // Cria uma fonte de imagem a partir dos dados do GIF
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
            print("Não foi possível criar CGImageSource.")
            return nil
        }
        
        let frameCount = CGImageSourceGetCount(source)
        var images = [UIImage]()
        var duration: Double = 0
        
        for i in 0..<frameCount {
            // Cria uma CGImage para cada frame
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else {
                continue
            }
            
            // Obtém as propriedades do frame
            let frameProperties = CGImageSourceCopyPropertiesAtIndex(source, i, nil) as Dictionary?
            let gifProperties = frameProperties?[kCGImagePropertyGIFDictionary] as? [String: Any]
            
            // Obtém a duração do frame
            let delayTime = gifProperties?[kCGImagePropertyGIFUnclampedDelayTime as String] as? Double
            ?? gifProperties?[kCGImagePropertyGIFDelayTime as String] as? Double
            ?? 0.1
            
            duration += delayTime
            images.append(UIImage(cgImage: cgImage))
        }
        
        // Cria a imagem animada
        return UIImage.animatedImage(with: images, duration: duration)
    }
}
