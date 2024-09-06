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
    
    @preconcurrency
    public func syncOnMainThread(execute: @escaping () -> Void) {
        provider.sync(execute: execute)
    }
    
    @MainActor @preconcurrency
    public func asyncAfter(delay: TimeInterval?, execute work: @escaping @Sendable @convention(block) () -> Void) {
        if let delay {
            let deadline: DispatchTime = .now() + delay
            self.asyncAfter(deadline: deadline, execute: work)
        } else {
            onMainThread(execute: work)
        }
    }
    
    @preconcurrency
    public func asyncAfter(delay: TimeInterval?, workItem: DispatchWorkItem) {
        var deadline: DispatchTime = .now()
        if let delay {
            deadline = .now() + delay
        }
        self.asyncAfter(deadline: deadline, execute: workItem)
    }
    
    public func asyncAfter(deadline: DispatchTime, qos: DispatchQoS = .unspecified, flags: DispatchWorkItemFlags = [], execute work: @escaping @Sendable @convention(block) () -> Void) {
        provider.asyncAfter(deadline: deadline, qos: qos, flags: flags, execute: work)
    }

    public func asyncAfter(wallDeadline: DispatchWallTime, qos: DispatchQoS = .unspecified, flags: DispatchWorkItemFlags = [], execute work: @escaping @Sendable @convention(block) () -> Void) {
        provider.asyncAfter(wallDeadline: wallDeadline, qos: qos, flags: flags, execute: work)
    }

    @preconcurrency
    public func asyncAfter(deadline: DispatchTime, execute: DispatchWorkItem) {
        provider.asyncAfter(deadline: deadline, execute: execute)
    }
    
    public func asyncAfter(wallDeadline: DispatchWallTime, execute: DispatchWorkItem) {
        provider.asyncAfter(wallDeadline: wallDeadline, execute: execute)
    }
}
