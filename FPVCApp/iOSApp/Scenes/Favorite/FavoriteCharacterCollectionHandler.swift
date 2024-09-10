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


protocol FavoriteCollectionHandlerDelegate: AnyObject {
    
    func routeToInfos(with data: MarvelCharacterData)
}


class FavoriteCollectionHandler: NSObject, KDSCollectionHandler, KDSCollectionDelegate {
    
    unowned let collection: KDSCollection
    
    weak var delegate: FavoriteCollectionHandlerDelegate?
    
    var data = [MarvelCharacterData]()
    
    
    // Handlers
    let dispatcher = KFDispatcherQueue(provider: DispatchQueue.main)
    
        
    // Outros
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
            self.data = data
            self.collection.updateData()
            self.collection.removeSpinner()
            self.showEmptyViewIfNeeded()
        }
    }
    
    func updateLastSelectedCellIfNeeded() {
        defer { lastCellSelected = nil }
        guard let lastCellSelected else { return }
        collection.reloadItems(at: [lastCellSelected])
    }
    
    
    // MARK: - Configurações
    private func createCell(at indexPath: IndexPath) -> UICollectionViewCell? {
        let cell = collection.reusableCell(as: FavoriteCharacterCell.self, for: indexPath)
        let row = indexPath.row
        
        let cellData = data[row]
        cell?.setupCell(with: cellData)
        cell?.tag = row
                
        return cell
    }
    
    private func showEmptyViewIfNeeded() {
        data.isEmpty
        ? collection.showEmptyView()
        : collection.hideEmptyView()
    }
}


// MARK: - + KDSCollectionHandler
extension FavoriteCollectionHandler {
    
    func registerCell(at collection: KDSCollection) {
        FavoriteCharacterCell.register(at: collection)
    }
}


// MARK: - + KDSCollectionDelegate
extension FavoriteCollectionHandler {
    
    var hasDataInCollection: Bool { data.isNotEmpty }
}


// MARK: - + Data Source
extension FavoriteCollectionHandler {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = createCell(at: indexPath)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = collection.layout.calculateCellWidth(collection, qtdCellsInRow: 1)
        size.height = collectionView.bounds.height * 0.15
        return size
    }
}


// MARK: - + Delegate
extension FavoriteCollectionHandler {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        lastCellSelected = indexPath
        let infos = data[indexPath.row]
        delegate?.routeToInfos(with: infos)
    }
}
