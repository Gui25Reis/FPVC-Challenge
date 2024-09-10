//
//  AppDelegate.swift
//  FPVCApp
//
//  Created by Gui Reis on 29/08/24.
//

import UIKit
import KingsStorage


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        var utils = MarvelAPIUtils(keychain: KeychainManager(), cache: CacheManager())
        utils.saveAPIInfos()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        FavoriteManager.shared.saveChangesIfNeeded()
    }
}
