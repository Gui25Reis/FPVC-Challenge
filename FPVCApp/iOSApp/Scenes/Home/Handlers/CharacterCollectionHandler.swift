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


protocol CharacterCollectionHandlerDelegate: AnyObject {
    
    func fetchMoreData()
    
    func routeToInfos(with data: MarvelCharacterData)
}


class CharacterCollectionHandler: NSObject, KDSCollectionHandler, ImagesDownloaderDelegate, KDSCollectionDelegate, CharacterFooterDelegate, CharacterCellDelegate {
    
    unowned let collection: KDSCollection
    
    weak var delegate: CharacterCollectionHandlerDelegate?
    
    var data = [MarvelCharacterData]()
    
    
    // Handlers
    let dispatcher = KFDispatcherQueue(provider: DispatchQueue.main)
    
    lazy var imgDownloader: ImagesDownloader = {
        let handler = ImagesDownloader()
        handler.delegate = self
        return handler
    }()
    
    
    // Outros
    var isLoadingNewData = false
    
    var lastCellSelected: IndexPath?
    
    
    // MARK: - Construtores
    required init(collection: KDSCollection) {
        self.collection = collection
        super.init()
        
        link(with: collection)
        collection.kdsDelegate = self
    }
    
    
    // MARK: - Encapsulamento
    func newData(_ data: [MarvelCharacterData]) {
        dispatcher.onMainThread {
            self.data += data
            self.collection.updateData()
            self.collection.removeSpinner()
            self.isLoadingNewData = false
        }
    }
    
    func temporaryNewData(_ data: [MarvelCharacterData]) {
        dispatcher.onMainThread {
            self.data += data
            self.collection.updateData()
            self.collection.removeSpinner()
        }
    }
    
    func updateLastSelectedCellIfNeeded() {
        defer { lastCellSelected = nil }
        guard let lastCellSelected else { return }
        collection.reloadItems(at: [lastCellSelected])
    }
    
    
    // MARK: - Configurações
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
//            print("[CollectionHandler] \(#function) | Atualizando a imagem da célula: \(indexPath)")
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
extension CharacterCollectionHandler {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = createCell(at: indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellRowCount: CGFloat = 2
        
        let hSpace = collection.layout.horizontalSpace + collection.padding.horizontals
        
        let totalSpacing: CGFloat = (cellRowCount - 1) * hSpace
        let width = (collectionView.bounds.width - totalSpacing) / cellRowCount
        let height = width * 1.2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let defaultView = UICollectionReusableView()
        guard KDSCollectionReusableViews(kind: kind) == .footer else { return defaultView }
        return createFooter(at: indexPath) ?? defaultView
    }
}


// MARK: - + Delegate
extension CharacterCollectionHandler {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return hasDataInCollection
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
extension CharacterCollectionHandler {
    
    func paginationAction() {
        isLoadingNewData = true
        delegate?.fetchMoreData()
    }
}


// MARK: - + KDSCollectionHandler
extension CharacterCollectionHandler {
    
    func registerCell(at collection: KDSCollection) {
        CharacterCell.register(at: collection)
        
        collection.registerView(for: CharacterFooter.self, ofKind: .footer)
    }
}


// MARK: - + KDSCollectionDelegate
extension CharacterCollectionHandler {
    
    var hasDataInCollection: Bool { data.isNotEmpty }
}


// MARK: - + ImagesDownloaderDelegate
extension CharacterCollectionHandler {
    
    func didDownloadImageSuccessfully(image: KDSImage, _ dict: [String: Any]) {
        updateCell(image: image, with: dict)
    }
    
    func didDownloadImageFailure(error: ImagesDownloaderErrors, _ dict: [String: Any]) {
        updateCell(image: KDSImage(), with: dict)
    }
}


// MARK: - + CharacterCellDelegate
extension CharacterCollectionHandler {
    
    func didChangeFavoriteStatus(_ cell: CharacterCell) {
        let data = data[cell.tag]
        
        data.didChangeFavoriteStatus()
        cell.updateFavoriteIcon(basedOn: data.isFavorited)
        
        FavoriteManager.shared.didChangeFavoriteStatus(data: data)
    }
}
