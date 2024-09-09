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


public extension UIView {
    
    /// Altura da nav bar
    var navBarHeight: CGFloat {
        let parent = parentController
    
        let nav = parent?.navigationController
        return nav?.navigationBar.frame.height ?? 0
    }
    
    /// Controller responsável pela view
    var parentController: UIViewController? {
        if let controller = self.next as? UIViewController {
            return controller
        }
        
        if let superview {
            return superview.parentController
        }
        
        return nil
    }
    
    /// Posisão final em que a view ocupa na superview (posição de origem + altura do componente)
    var finalPosition: CGFloat { frame.origin.y + frame.height }
    
    /// Origem Y do Frame
    var originY: CGFloat { frame.origin.y }
    
    /// Origem X do Frame
    var originX: CGFloat { frame.origin.x }
    
    /// Boleano que indica se a view possui uma superview ou não
    var hasSuperview: Bool {
        superview != nil
    }
    
    ///
    var safeArea: UILayoutGuide { safeAreaLayoutGuide }
    
    /// Boleano que indica que há a necessidade de configurar a hierarquia e as constraints
    @objc var needsToCreateHierarchy: Bool {
        hasSuperview && subviews.isEmpty
    }
    
    
    // MARK: - Constraints
    func activateConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func removeAllConstraints() {
        defer { removeConstraints(constraints) }
        
        let constraints = checkIfHasContraintsAttached(to: superview)
        guard let constraints else { return }
        superview?.removeConstraints(constraints)
    }
    
    /// Cria as constraints de top, bottom, left e right atreladas à uma view (superview)
    func strechToBounds(of view: UIView?, space: CGFloat = 0) -> [NSLayoutConstraint] {
        guard let view = view else { return [] }
        activateConstraints()
        
        return [
            topAnchor.constraint(equalTo: view.topAnchor, constant: space),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -space),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: space),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -space)
        ]
    }
    
    /// Cria as constraints de top, bottom, left e right atreladas à safe area de uma view (superview)
    func strechToSafeAreaBounds(of view: UIView?, space: CGFloat = 0) -> [NSLayoutConstraint] {
        guard let view = view else { return [] }
        activateConstraints()
        
        return [
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: space),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -space),
            leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: space),
            rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -space)
        ]
    }
    
    /// Cria as constraints necessárias para centralizar a view em uma view (superview)
    func centerView(on view: UIView?, lateralSpace: CGFloat = 0) -> [NSLayoutConstraint] {
        guard let view = view else { return [] }
        activateConstraints()
        
        center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        return [
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: lateralSpace),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: -lateralSpace)
        ]
    }
    
    func checkIfHasContraintsAttached(to view: UIView?) -> [NSLayoutConstraint]? {
        guard let view else { return nil }
        
        let constraints = view.constraints.filter {
            $0.firstItem === self || $0.secondAnchor === self
        }
        
        if constraints.isEmpty { return nil }
        return constraints
    }
}
