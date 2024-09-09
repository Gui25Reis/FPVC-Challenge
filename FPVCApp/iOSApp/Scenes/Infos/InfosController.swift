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


class InfosController: UIViewController, InfosCharacterTableHandlerDelegate {
    
    lazy var screen: InfosScreen = {
        let view = InfosScreen()
        return view
    }()
    
    let characterInfos: MarvelCharacterData
    
    var tableHandler: InfosCharacterTableHandler?
    
    var dispatcher = KFDispatcherQueue(provider: DispatchQueue.main)
    var accessRequest: KFAccessRequestLogic = KFAccessRequest.shared
    
    
    // MARK: - Construtores
    init(characterInfos: MarvelCharacterData) {
        self.characterInfos = characterInfos
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    
    // MARK: - Ciclo de Vida
    override func loadView() {
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAndSetupTable()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        FavoriteManager.shared.saveChangesIfNeeded()
    }
    
    
    // MARK: - InfosCharacterTableHandlerDelegate
    func shareImage(_ image: KDSImage?) {
        accessRequest.checkPermission(for: .gallery) { [weak self] response in
            guard let self else { return }
            
            guard let alert = response.alert else {
                self.shareWithActivity(data: image?.imageCreated)
                return
            }
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
                self.shareWithActivity(data: image?.imageCreated)
            }
            alert.addAction(okAction)
            self.dispatcher.onMainThread {
                self.present(alert, animated: true)
            }
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
            action: { [weak self] _ in
                self?.shareWithActivity(data: self?.characterInfos.toShare)
            }
        )
        
        let favoriteIcon = KDSIcons.favoriteIcon(basedOn: characterInfos.isFavorited)
        let favoriteButton = KDSNavButton(
            image: KDSImage(asset: favoriteIcon),
            color: KDSColors.accentButton,
            action: { [weak self] button in self?.favoriteAction(at: button) }
        )
        
        UIStackView.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).spacing = -8
        navigationItem.rightBarButtonItems = [shareButtom, favoriteButton]
    }
    
    private func createAndSetupTable() {
        tableHandler = InfosCharacterTableHandler(
            table: screen.tableView, data: characterInfos
        )
        tableHandler?.delegate = self
    }
    
    private func shareWithActivity(data: Any?) {
        guard let data else { return }
        let activityController = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        
        dispatcher.onMainThread {
            self.present(activityController, animated: true)
        }
    }
    
    private func favoriteAction(at button: KDSNavButton) {
        characterInfos.isFavorited.toggle()
        let favoriteIcon = KDSIcons.favoriteIcon(basedOn: characterInfos.isFavorited)
        button.kdsImage = KDSImage(asset: favoriteIcon)
        FavoriteManager.shared.didChangeFavoriteStatus(data: characterInfos)
    }
}
