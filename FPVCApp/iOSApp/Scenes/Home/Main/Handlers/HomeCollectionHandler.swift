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
import FPVCAssets


protocol HomeCollectionHandlerDelegate: AnyObject {
    
    func fetchMoreData()
    
    func routeToInfos(with data: MarvelCharacterData)
}


protocol HomeCollectionHandlerLogic: AnyObject {
    
    var canLoadMoreData: Bool { get set }
    
    func cleanData()
    
    func newData(_ newData: [MarvelCharacterData])
    
    func updateLastSelectedCellIfNeeded()
}


class HomeCollectionHandler: NSObject, HomeCollectionHandlerLogic, KDSCollectionHandler, ImagesDownloaderDelegate, KDSCollectionDelegate, CharacterFooterDelegate, CharacterCellDelegate {
    
    unowned let collection: KDSCollection
    
    weak var delegate: HomeCollectionHandlerDelegate?
    
    var data = [MarvelCharacterData]()
    
    
    // Handlers
    lazy var dispatcher = KFDispatcherQueue(provider: DispatchQueue.main)
    
    lazy var imgDownloader: ImagesDownloaderLogic = {
        let handler = ImagesDownloader()
        handler.delegate = self
        return handler
    }()
    
    
    // Outros
    var isLoadingNewData = false
    
    var lastCellSelected: IndexPath?
    
    var canLoadMoreData = false
    
    
    // MARK: - Construtores
    required init(collection: KDSCollection) {
        self.collection = collection
        super.init()
        
        link(with: collection)
        collection.kdsDelegate = self
    }
    
    
    // MARK: - Encapsulamento
    func cleanData() {
        isLoadingNewData = false
        
        dispatcher.onMainThread {
            self.data = []
            self.collection.updateData()
        }
    }
    
    func newData(_ newData: [MarvelCharacterData]) {
        isLoadingNewData = false
        
        dispatcher.onMainThread {
            if newData.isNotEmpty {
                self.data += newData
                self.collection.updateData()
            }
            
            self.showEmptyViewIfNeeded()
            self.realoadFooterIfNeeded()
        }
    }
    
    func updateLastSelectedCellIfNeeded() {
        defer { lastCellSelected = nil }
        guard let lastCellSelected else { return }
        collection.reloadItems(at: [lastCellSelected])
    }
    
    
    // MARK: - Configurações
    
    /* Geral */
    @MainActor
    private func showEmptyViewIfNeeded() {
        data.isEmpty
        ? collection.showEmptyView()
        : collection.hideEmptyView()
        collection.removeSpinner()
    }
    
    @MainActor
    private func realoadFooterIfNeeded() {
        guard data.isNotEmpty else { return }
        let kind: KDSCollectionReusableViews = .footer
        
        let visibleFooters = collection.visibleSupplementaryViews(ofKind: kind.key)
        visibleFooters.first?.prepareForReuse()
    }
    
    
    // MARK: UI
    private func createCell(at indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = collection.reusableCell(as: CharacterCell.self, for: indexPath)
        let row = indexPath.row
        
        let cellData = data[row]
        let image = downloadImageIfNeeded(at: indexPath)
        cell?.setupCell(with: cellData, image: image)
        cell?.tag = row
        cell?.delegate = self
        
        return cell
    }
    
    private func downloadImageIfNeeded(at indexPath: IndexPath) -> KDSImage? {
        let data = self.data[indexPath.row]
        
        if let image = data.image.image {
            return image
        }
        
        let image = imgDownloader.downloadFromWeb(
            imageURL: data.image.url,
            dict: [
                "indexPath": indexPath,
                "fileName": data.image.imageName
            ]
        )
        data.image.image = image
        return image
    }
    
    private func updateCell(image: KDSImage, with dict: [String: Any]) {
        guard let indexPath = dict["indexPath"] as? IndexPath else { return }
        data[indexPath.row].image.image = image
        
        dispatcher.onMainThread {
            let cell = self.collection.cellForItem(at: indexPath) as? CharacterCell
            if let cell {
                image.createIfEmpty(asset: FPVCAsset.imageEmptyState)
                cell.imageView.setupImage(with: image)
            } else {
                self.collection.reloadItems(at: [indexPath])
            }
        }
    }
    
    private func createFooter(at indexPath: IndexPath) -> UICollectionReusableView? {
        let type: KDSCollectionReusableViews = .footer
        let footer = collection.reusableView(as: CharacterFooter.self, ofKind: type.key, for: indexPath)
        footer?.delegate = self
        
        isLoadingNewData ? footer?.isFetchingNewData() : Void()
        return footer
    }
}


// MARK: - + Data Source
extension HomeCollectionHandler {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = createCell(at: indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = collection.layout.calculateCellWidth(collection, qtdCellsInRow: 2)
        size.height = size.width * 1.2
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let defaultView = UICollectionReusableView()
        
        let kindType = KDSCollectionReusableViews(kind: kind)
        guard kindType == .footer else { return defaultView }
        
        let footer = createFooter(at: indexPath)
        return footer ?? defaultView
    }
}


// MARK: - + Delegate
extension HomeCollectionHandler {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return hasDataInCollection && canLoadMoreData
        ? CGSize(width: collectionView.frame.width, height: 44)
        : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lastCellSelected = indexPath
        let infos = data[indexPath.row]
        delegate?.routeToInfos(with: infos)
    }
}



// MARK: - + CharacterFooterDelegate
extension HomeCollectionHandler {
    
    func paginationAction() {
        isLoadingNewData = true
        delegate?.fetchMoreData()
    }
}


// MARK: - + KDSCollectionHandler
extension HomeCollectionHandler {
    
    func registerCell(at collection: KDSCollection) {
        CharacterCell.register(at: collection)
        
        collection.registerView(for: CharacterFooter.self, ofKind: .footer)
    }
}


// MARK: - + KDSCollectionDelegate
extension HomeCollectionHandler {
    
    var hasDataInCollection: Bool { data.isNotEmpty }
}


// MARK: - + ImagesDownloaderDelegate
extension HomeCollectionHandler {
    
    func didDownloadImageSuccessfully(image: KDSImage, _ dict: [String: Any]) {
        updateCell(image: image, with: dict)
    }
    
    func didDownloadImageFailure(error: ImagesDownloaderErrors, _ dict: [String: Any]) {
        updateCell(image: KDSImage(), with: dict)
    }
}


// MARK: - + CharacterCellDelegate
extension HomeCollectionHandler {
    
    func didChangeFavoriteStatus(_ cell: CharacterCell) {
        let data = data[cell.tag]
        
        data.didChangeFavoriteStatus()
        cell.updateFavoriteIcon(basedOn: data.isFavorited)
        
        FavoriteManager.shared.didChangeFavoriteStatus(data: data)
    }
}
