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
import Photos


class GalleryFeature: KFAccessRequestFeature {
    
    static var didCreateAlertBefore = false
    
    let levelAccess: PHAccessLevel
    
    var featurePermission: PHAuthorizationStatus {
        PHPhotoLibrary.authorizationStatus(for: levelAccess)
    }
    
    var didResquest = false
    
    
    // MARK: - Construtor
    init(levelAccess: PHAccessLevel) {
        self.levelAccess = levelAccess
    }
    
    
    // MARK: - KFAccessRequestFeature
    func checkPermission(_ handler: @escaping (KFAccessResponse) -> Void) {
        let permission = KFAccessRequestStatus(photos: featurePermission)
        
        var response = KFAccessResponse(
            hasPermission: false, statusType: permission, alert: nil
        )
        
        switch permission {
        case .denied, .restricted:
            response.alert = makeDeniedAlert()
        
        case .authorized, .limited:
            response.hasPermission = true
        
        case .notDetermined:
            if didResquest {
                response.statusType = .denied
            } else {
                return requestAuthorization(handler)
            }
        default:
            break
        }
        
        handler(response)
    }
    
    
    // MARK: - Configurações
    private func requestAuthorization(_ handler: @escaping (KFAccessResponse) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: levelAccess) { newStatus in
//            let permission = KFAccessRequestStatus(photos: newStatus)
            self.didResquest = true
            self.checkPermission(handler)
        }
    }
    
    // MARK: Alertas
    private func makeDeniedAlert() -> UIAlertController? {
        guard !Self.didCreateAlertBefore else { return nil }
        
        let alert = UIAlertController(
            title: "Atenção",
            message: "O acesso à galeria está negado. Caso queria salvar a imagem na galeria é necessário alterar a permissão do aplicativo nas configurações.",
            preferredStyle: .alert
        )
    
        let settingAction = UIAlertAction(title: "Configurações", style: .default) { _ in
            let settingsUrl = UIApplication.openSettingsURLString
            let url = URL(string: settingsUrl)
            guard let url else { return }
            UIApplication.shared.open(url)
        }
    
        alert.addAction(settingAction)
        Self.didCreateAlertBefore = true
        return alert
    }
}
