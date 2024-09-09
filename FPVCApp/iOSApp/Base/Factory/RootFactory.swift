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
import KingsDS


enum RootFactory {
    
    static func makeRoot() -> UIViewController {
        let tab = createTab()
        
        let homeController = HomeViewController()
        let favoriteController = FavoriteController()
        
        tab.viewControllers = [
            createNavigation(for: homeController),
            createNavigation(for: favoriteController)
        ]
        
        return tab
    }
    

    private static func createTab() -> UITabBarController {
        let tab = UITabBarController()
        
        let mainColor = KDSColors.red
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = mainColor
                
        tab.tabBar.standardAppearance = appearance
        tab.tabBar.scrollEdgeAppearance = appearance
        
        tab.tabBar.tintColor = KDSColors.accentButton
        return tab
    }
    
    private static func createNavigation(for root: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: root)
        
        let mainColor = KDSColors.red
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = mainColor
        
        let titleAttribute = [
//            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        appearance.titleTextAttributes = titleAttribute
        appearance.largeTitleTextAttributes = titleAttribute
        
        navigation.navigationBar.standardAppearance = appearance
        navigation.navigationBar.scrollEdgeAppearance = appearance
        
        navigation.navigationBar.titleTextAttributes = titleAttribute
        navigation.navigationBar.largeTitleTextAttributes = titleAttribute
        navigation.navigationBar.tintColor = KDSColors.accentButton
        navigation.navigationBar.backgroundColor = mainColor
        
        navigation.navigationBar.prefersLargeTitles = true
        return navigation
    }
    
    
    
}
