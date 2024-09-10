//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import KingsFoundation

class KFDispatchQueueMock {
    
    var didCallAsync = false
}


extension KFDispatchQueueMock: KFDispatchQueueType {
    
    func async(group: DispatchGroup?, qos: DispatchQoS, flags: DispatchWorkItemFlags, execute work: @escaping @Sendable @convention(block) () -> Void) {
        didCallAsync = true
        work()
    }
    
    
}


extension KFDispatchQueueMock: MockProtocol {
    
    func clearVariables() {
        didCallAsync = false
    }
}
