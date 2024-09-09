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


public protocol KFAccessRequestLogic {
    
    func checkPermission(for feature: KFAccessRequestTypes, _ handler: @escaping (KFAccessResponse) -> Void)
}


public class KFAccessRequest: KFAccessRequestLogic {
    
    public static var shared = KFAccessRequest()
    
    
    // MARK: - Construtores
    private init() {
        /* Forçando o uso do singleton */
    }
    
    
    public func checkPermission(for feature: KFAccessRequestTypes, _ handler: @escaping (KFAccessResponse) -> Void) {
        switch feature {
        case .gallery:
            checkGalleryPermission(handler)
        }
    }
    
    
    // MARK: - Features
    func checkGalleryPermission(_ handler: @escaping (KFAccessResponse) -> Void) {
        let feature = GalleryFeature(levelAccess: .addOnly)
        feature.checkPermission(handler)
    }
}
