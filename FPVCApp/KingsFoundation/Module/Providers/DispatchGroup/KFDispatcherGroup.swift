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


struct KFDispatcherGroup {
    
    public let provider: KFDispatchGroupType
    
    
    public init(provider: KFDispatchGroupType) {
        self.provider = provider
    }
    
    
    // MARK: - Ações
    public func notifyOnMain(execute work: @escaping @convention(block) () -> Void) {
        self.notify(queue: .main, execute: work)
    }
    
    public func notify(qos: DispatchQoS = .unspecified, flags: DispatchWorkItemFlags = [], queue: DispatchQueue, execute work: @escaping @convention(block) () -> Void) {
        provider.notify(qos: qos, flags: flags, queue: queue, execute: work)
    }
    
    public func notify(queue: DispatchQueue, work: DispatchWorkItem) {
        provider.notify(queue: queue, work: work)
    }
    
    public func wait() {
        provider.wait()
    }
    
    public func wait(timeout: DispatchTime) -> DispatchTimeoutResult {
        return provider.wait(timeout: timeout)
    }
    
    public func wait(wallTimeout timeout: DispatchWallTime) -> DispatchTimeoutResult {
        return provider.wait(wallTimeout: timeout)
    }
    
    public func enter() {
        provider.enter()
    }
    
    public func leave() {
        provider.leave()
    }
}
