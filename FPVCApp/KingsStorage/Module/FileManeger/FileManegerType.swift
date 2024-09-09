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


public class FileManegerType {
    
    var directoryType: FileManager.SearchPathDirectory
    
    var directoryURL: NSURL? {
        try? FileManager.default.url(
            for: directoryType, in: .userDomainMask, appropriateFor: nil, create: false
        ) as NSURL
    }
    
    
    public init(directoryType: FileManager.SearchPathDirectory) {
        self.directoryType = directoryType
    }
    
    public func checkIfFileExists(at path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    public func getFilePath(fileName: String) -> String? {
        let fileUrl = directoryURL?.appendingPathComponent(fileName)
        let filePath = fileUrl?.path
        
        guard let filePath, checkIfFileExists(at: filePath)
        else { return nil }
        
        return filePath
    }
}
