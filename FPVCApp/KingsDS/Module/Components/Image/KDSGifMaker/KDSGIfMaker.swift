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


class KDSGifMaker {
    
    let data: Data
    
    private var source: CGImageSource?
    private lazy var duration: Double = 0.0
    private lazy var images = [UIImage]()
    
    
    /* Construtores */
    init(data: Data) {
        self.data = data
    }
    
    
    /* Encapsulamento */
    func makeImage() -> UIImage? {
        let source = CGImageSourceCreateWithData(data as CFData, nil)
        guard let source else { return nil }
        
        let frameCount = CGImageSourceGetCount(source)
        
        if frameCount == 1 { // Imagem Estática
            return UIImage(data: data)
        }
        
        defer { cleanData() }
        
        self.source = source
        createImageFromFrames(frameCount: frameCount)
        
        return UIImage.animatedImage(with: images, duration: duration)
    }
    
    
    /* Configurações */
    private func createImageFromFrames(frameCount: Int) {
        guard let source else { return }
        for i in 0..<frameCount {
            let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil)
            guard let cgImage else { continue }
            
            updateDurationBasedOnEachFrame(atIndex: i)
            
            let image = UIImage(cgImage: cgImage)
            images.append(image)
        }
    }
    
    private func updateDurationBasedOnEachFrame(atIndex index: Int) {
        guard let source else { return }
        
        let frameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) as Dictionary?
        let gifProperties = frameProperties?[kCGImagePropertyGIFDictionary] as? [String: Any]
        
        let delayTime = gifProperties?[kCGImagePropertyGIFUnclampedDelayTime as String] as? Double
            ?? gifProperties?[kCGImagePropertyGIFDelayTime as String] as? Double
            ?? 0.1
        
        duration += delayTime
    }
    
    private func cleanData() {
        source = nil
        duration = 0.0
        images.removeAll()
    }
}
