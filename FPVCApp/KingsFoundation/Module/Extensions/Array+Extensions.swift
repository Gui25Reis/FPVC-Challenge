//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

public extension Array {
    
    @inlinable var second: Element? {
        guard count >= 2 else { return nil }
        return self[1]
    }
    
    @inlinable var isNotEmpty: Bool {
        isEmpty == false
    }
    
    var indexRange: Range<Int> {
        0..<count
    }
    
    @discardableResult
    mutating func appendIfExists(_ newElement: Element?) -> Bool {
        guard let newElement else { return false }
        append(newElement)
        return true
    }
    
    @discardableResult
    mutating func removeRandomElement() -> Element? {
        let randomIndex = indexRange.randomElement()
        guard let randomIndex else { return nil }
        
        return remove(at: randomIndex)
    }
}
