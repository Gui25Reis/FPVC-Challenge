//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//


public enum KDSFileType {
    case svg
    case png
    case system
}



public struct KDSFile {
    public var name: String
    public var type: KDSFileType
    public var bundle: Bundle
    
    
    public init(name: String, type: KDSFileType, bundle: Bundle? = nil) {
        self.name = name
        self.type = type
        self.bundle = bundle ?? Bundle.kingsDS
    }
    
    public init(assetName name: String, type: KDSFileType = .svg, bundle: Bundle? = nil) {
        self.init(name: name, type: type, bundle: nil)
    }
    
    public init(systemName name: String, type: KDSFileType = .system) {
        self.init(name: name, type: type, bundle: nil)
    }
}
