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


public protocol KFDispatchQueueType: AnyObject {
    func async(group: DispatchGroup?, qos: DispatchQoS, flags: DispatchWorkItemFlags, execute work: @escaping @Sendable @convention(block) () -> Void)
}


// MARK: - DispatchQueue + KFDispatchQueueType
extension DispatchQueue: KFDispatchQueueType {
    /* Deixando de acordo com o protocolo */
}
