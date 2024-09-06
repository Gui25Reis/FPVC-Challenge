//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import Foundation


public protocol KFDispatchGroupType: AnyObject {
    func notify(qos: DispatchQoS, flags: DispatchWorkItemFlags, queue: DispatchQueue, execute work: @escaping @convention(block) () -> Void)
    func notify(queue: DispatchQueue, work: DispatchWorkItem)
    
    func wait()
    func wait(timeout: DispatchTime) -> DispatchTimeoutResult
    func wait(wallTimeout timeout: DispatchWallTime) -> DispatchTimeoutResult
    
    func enter()
    func leave()
}


// MARK: - DispatchGroup + KFDispatchGroupType
extension DispatchGroup: KFDispatchGroupType {
    /* Deixando de acordo com o protocolo */
}
