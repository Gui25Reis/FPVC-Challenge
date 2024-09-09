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



class KDSMainDispatcher {
    
    static var dispatcher = KFDispatcherQueue(provider: DispatchQueue.main)
    
    @preconcurrency
    static func onMainThread(execute work: @escaping @Sendable @convention(block) () -> Void) {
        dispatcher.onMainThread(execute: work)
    }
}
