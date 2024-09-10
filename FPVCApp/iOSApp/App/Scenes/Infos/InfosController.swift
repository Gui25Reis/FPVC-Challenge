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
import KingsFoundation


protocol InfosPresenter: AnyObject {
    
    var screen: InfosScreen { get set }
    
    func show(controller: UIViewController)
}


class InfosController: UIViewController, InfosPresenter {
    
    lazy var screen = InfosScreen()
        
    var dispatcher: KFDispatcherQueue?
    let viewModel: InfosViewModelLogic
    
    
    // MARK: - Construtores
    init(viewModel: InfosViewModelLogic) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    
    // MARK: - Ciclo de Vida
    override func loadView() {
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setupTable()
        setupNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        FavoriteManager.shared.saveChangesIfNeeded()
    }
    
    
    // MARK: - InfosPresenter
    func show(controller: UIViewController) {
        dispatcher?.onMainThread {
            self.present(controller, animated: true)
        }
    }
    
    
    // MARK: - Configurações
    private func setupNavigation() {
        hideTabBar()
        navigationItem.title = "Infos"
        navigationItem.largeTitleDisplayMode = .never
        
        let shareButtom = KDSNavButton(
            image: KDSImage(asset: KDSIcons.share),
            color: KDSColors.accentButton,
            action: { [weak self] _ in self?.viewModel.shareInfos() }
        )
        
        let favoriteIcon = KDSIcons.favoriteIcon(basedOn: viewModel.retrieveFavoriteStatus())
        let favoriteButton = KDSNavButton(
            image: KDSImage(asset: favoriteIcon),
            color: KDSColors.accentButton,
            action: { [weak self] button in self?.favoriteAction(at: button) }
        )
        
        UIStackView.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).spacing = -8
        navigationItem.rightBarButtonItems = [shareButtom, favoriteButton]
    }
    
    private func favoriteAction(at button: KDSNavButton) {
        let newStatus = viewModel.didChangeFavoriteStatus()
        let favoriteIcon = KDSIcons.favoriteIcon(basedOn: newStatus)
        button.kdsImage = KDSImage(asset: favoriteIcon)
    }
}
