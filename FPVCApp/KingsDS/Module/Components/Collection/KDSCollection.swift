//
//  Gui Reis  -  gui.sreis25@gmail.com
//
//
//  Copyright © 2024 Gui Reis.
//
//  Este código foi criado por Gui Reis e não pode ser reproduzido,
//  distribuído ou usado para fins comerciais sem autorização prévia do autor.
//

/* Bibliotecas necessárias: */
import UIKit
import KingsFoundation


/// Collection costumizada
open class KDSCollection: UICollectionView, KDSComponent, KDSDataCollection, KDSSpinnerHandler, KDSEmptyViewHandler {
    
    open override var bounds: CGRect {
        didSet { showSpinnerIfCan(style: .large) }
    }
    
    public weak var kdsDelegate: KDSCollectionDelegate?
    
    public var layout: KDSCollectionLayout
    
    public var padding: UIEdgeInsets = .zero {
        didSet { contentInset = padding }
    }
    
    public var registrations = [String: KDSCollectionReusableViews]()
    
    
    /* KDSSpinnerHandler */
    public var loadingIndicator: UIActivityIndicatorView?
    
    public var canShowSpinner: Bool {
        loadingIndicator.isNil 
        && !bounds.isEmpty
        && (kdsDelegate?.hasDataInCollection).isFalse
        && emptyView.isHidden
        && isAllowedToShowSpinner
    }
    
    public var isAllowedToShowSpinner = true
    
    
    /* KDSEmptyViewHandler */
    open lazy var emptyView = KDSEmptyView(viewModel: emptyViewVM)
    
    open var emptyViewVM = KDSEmptyViewVM(title: "", message: "")
    
    
    
    /* MARK: - Construtor */
    
    public init() {
        layout = KDSCollectionLayout()
        super.init(frame: .zero, collectionViewLayout: layout)
        initialSetup()
    }
    
    required public init?(coder: NSCoder) { return nil }
    
    
    /* MARK: - Overrides */
    
    open override func reloadData() {
        kdsDelegate?.willReloadData()
        super.reloadData()
        kdsDelegate?.didReloadData()
    }
    
    
    /* MARK: - KDSDataCollection */
    
    final public func registerCell<T>(for cell: T.Type) where T : KDSCustomComponent {
        guard let cell = cell as? KDSCollectionCellType.Type else { return }
        register(cell, forCellWithReuseIdentifier: cell.identifier)
        registrations[cell.identifier] = .cell
    }
    
    final public func reusableCell<T: KDSCustomComponent>(as cell: T.Type, for indexPath: IndexPath?) -> T? {
        guard checkIfCellIsRegistered(id: cell.identifier), let indexPath else { return nil }
        return dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as? T
    }
    
    final public func checkIfCellIsRegistered(id: String) -> Bool {
        return registrations[id] != nil
    }
    
    
    // Header & Footers
    final public func registerView<T>(for view: T.Type, ofKind kind: KDSCollectionReusableViews) where T: KDSCustomComponent {
        guard let view = view as? KDSCollectionReusableViewType.Type else { return }
        register(view, forSupplementaryViewOfKind: kind.key, withReuseIdentifier: view.identifier)
        registrations[view.identifier] = kind
    }
    
    final public func reusableView<T: KDSCustomComponent>(as view: T.Type, ofKind kind: String, for indexPath: IndexPath?) -> T? {
        guard checkIfViewIsRegistered(id: view.identifier), let indexPath else { return nil }
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: view.identifier, for: indexPath) as? T
    }
    
    final public func checkIfViewIsRegistered(id: String) -> Bool {
        return registrations[id] != nil
    }
    
        
    /* MARK: - KDSComponent */
    
    /// Configura a view
    final public func initialSetup() {
        activateConstraints()
        
        clipsToBounds = true
        layer.masksToBounds = true
    }
    
    public func showEmptyView() {
        removeSpinner(forced: true)
        
        let handler = superview as? KDSEmptyViewHandler
        handler?.showEmptyView()
        emptyView.isHidden = false
    }
    
    public func hideEmptyView() {
        let handler = superview as? KDSEmptyViewHandler
        handler?.hideEmptyView()
        emptyView.isHidden = true
    }
}
