//
//  SceneDelegate.swift
//  FPVCApp
//
//  Created by Gui Reis on 29/08/24.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = RootFactory.makeRoot()
        window?.makeKeyAndVisible()
    }
}
