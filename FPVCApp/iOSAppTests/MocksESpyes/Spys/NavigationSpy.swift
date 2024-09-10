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

class NavigationSpy: UINavigationController {
    
    var lastPresentedViewController: UIViewController?
    var lastPopedViewController: UIViewController?
    
    var presentCalled = false
    var dismissCalled = false
    var popActionCalled = false
    var popToControllerActionCalled = false
    var popToRootActionCalled = false
    var pushActionCalled = false
    var setViewControllersCalled = false
    var didSetupNavigation = false
    
    var animatedStatusReceived: Bool?
    
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        lastPresentedViewController = viewControllerToPresent
        
        presentCalled = true
        animatedStatusReceived = flag
        
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCalled = true
        
        animatedStatusReceived = true
        
        super.dismiss(animated: flag, completion: completion)
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        pushActionCalled = true
        
        lastPresentedViewController = viewController
        animatedStatusReceived = animated
        
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        popActionCalled = true
        
        animatedStatusReceived = animated
        
        return super.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        popToRootActionCalled = true
        
        animatedStatusReceived = animated
        
        return super.popToRootViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        popToControllerActionCalled = true
        
        lastPopedViewController = viewController
        animatedStatusReceived = animated
        
        return super.popToViewController(viewController, animated: animated)
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        setViewControllersCalled = true
        
        lastPresentedViewController = viewControllers.first
        animatedStatusReceived = animated
        
        super.setViewControllers(viewControllers, animated: animated)
    }
}


// MARK: - + SpyProtocol
extension NavigationSpy: SpyProtocol {
    
    func clearVariables() {
        presentCalled = false
        popActionCalled = false
        popToControllerActionCalled = false
        popToRootActionCalled = false
        pushActionCalled = false
        setViewControllersCalled = false
        didSetupNavigation = false
        
        lastPresentedViewController = nil
        lastPopedViewController = nil
        
        animatedStatusReceived = nil
    }
}
