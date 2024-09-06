//
//  SceneDelegate.swift
//  FPVCApp
//
//  Created by Gui Reis on 29/08/24.
//

import UIKit
import KingsDS


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = createRoot()
        window?.makeKeyAndVisible()
    }
    
    
    private func createRoot() -> UIViewController {
        let rootController = HomeViewController()
        
        let navigation = UINavigationController(rootViewController: rootController)
        
        let mainColor = KDSColors.red
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = mainColor
        
        let titleAttribute = [
//            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        appearance.titleTextAttributes = titleAttribute
        
        navigation.navigationBar.standardAppearance = appearance
        navigation.navigationBar.scrollEdgeAppearance = appearance
        
        navigation.navigationBar.tintColor = mainColor
        navigation.navigationBar.backgroundColor = mainColor
        
        navigation.navigationBar.prefersLargeTitles = true
        return navigation
    }
}
