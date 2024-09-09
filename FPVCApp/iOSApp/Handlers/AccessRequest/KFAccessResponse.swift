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


public struct KFAccessResponse {
    public var hasPermission: Bool
    public var statusType: KFAccessRequestStatus
    public var alert: UIAlertController?
    
    
    init(hasPermission: Bool, statusType: KFAccessRequestStatus, alert: UIAlertController?) {
        self.hasPermission = hasPermission
        self.statusType = statusType
        self.alert = alert
    }
}
