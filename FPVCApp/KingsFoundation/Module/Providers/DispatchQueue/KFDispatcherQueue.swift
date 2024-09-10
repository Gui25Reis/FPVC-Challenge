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


public struct KFDispatcherQueue {
    
    public let provider: KFDispatchQueueType
    
    
    public init(provider: KFDispatchQueueType) {
        self.provider = provider
    }
    
    
    // MARK: - Ações
    @preconcurrency
    public func async(execute work: @escaping @Sendable @convention(block) () -> Void) {
        provider.async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
    
    @preconcurrency
    public func onMainThread(execute work: @escaping @Sendable @convention(block) () -> Void) {
        provider.async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
