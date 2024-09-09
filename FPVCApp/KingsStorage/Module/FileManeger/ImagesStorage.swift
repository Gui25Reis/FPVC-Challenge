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


public class ImagesStorage: FileManegerType, StorageHadler {
    
    public typealias StorageData = UIImage
    
    
    // MARK: - StorageHadler
    public func save(_ image: StorageData, forKey key: String) {
        let fileUrl = directoryURL?.appendingPathComponent(key)
        
        let data = image.jpegData(compressionQuality: 1)
        
        guard let data, let fileUrl else { return }
        try? data.write(to: fileUrl)
    }
    
    public func retrieve(forKey key: String) -> StorageData? {
        guard let filePath = getFilePath(fileName: key)
        else { return nil }
        
        return UIImage(contentsOfFile: filePath)
    }
    
    public func delete(forKey key: String) {
        guard let filePath = getFilePath(fileName: key)
        else { return }
        
        try? FileManager.default.removeItem(atPath: filePath)
    }
    
    
    /* NÃO UTILIZADO */
    public func retrieveAll() -> [StorageData] { [] }
    
    public func cleanAll() {
        
    }
}
