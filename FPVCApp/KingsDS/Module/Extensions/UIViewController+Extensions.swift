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


extension UIViewController {
    
    @objc open var controllerTitle: String? { title }
    
    
    public func setupTabBar(title: String? = nil, image: KDSImage) {
        tabBarItem.title = title ?? controllerTitle
        tabBarItem.image = image.imageCreated
    }
    
    public func hideTabBar() {
        tabBarController?.tabBar.isHidden = true
    }
    
    public func showTabBar() {
        tabBarController?.tabBar.isHidden = false
    }
}
