//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

import Photos


public enum KFAccessRequestStatus {
    case notDetermined
    case restricted
    case denied
    case authorized
    case limited
    case unknown
    
    
    // MARK: Galeria (Photos)
    init(photos: PHAuthorizationStatus) {
        switch photos {
        case .notDetermined:
            self = .notDetermined
        case .restricted:
            self = .restricted
        case .denied:
            self = .denied
        case .authorized:
            self = .authorized
        case .limited:
            self = .limited
        @unknown default:
            self = .unknown
        }
    }
}
