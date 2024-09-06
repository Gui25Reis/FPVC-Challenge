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


public extension Optional {
    
    var isNil: Bool { self == nil }
    
    var isNotNil: Bool { self != nil }
    
    
    var string: String {
        if let self {
            return "\(self)"
        }
        return "nil"
    }
    
    func ifWrapped(then action: (Self) -> Void) {
        guard let self else { return }
        action(self)
    }
}


// MARK: - Bool?
public extension Optional where Wrapped == Bool {
    
    var isFalse: Bool { self == false }
    
    var isTrue: Bool { self == true }
}


// MARK: - String?
public extension Optional where Wrapped == String {
    
    var defaultValue: String {
        self ?? ""
    }
}


// MARK: - Collections? (RangeReplaceableCollection)
public extension Optional where Wrapped == any RangeReplaceableCollection {
    
    var hasData: Bool {
        isNotNil && self?.isEmpty == false
    }
}



// MARK: - Int?
public extension Optional where Wrapped == Int {
    
    var defaultValue: Int {
        self ?? .zero
    }
}
