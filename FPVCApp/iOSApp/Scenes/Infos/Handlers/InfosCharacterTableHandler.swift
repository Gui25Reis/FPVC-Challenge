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


protocol InfosCharacterTableHandlerDelegate: AnyObject {
    
    func shareImage(_ image: KDSImage?)
}


final class InfosCharacterTableHandler: NSObject, KDSTableHandler {
    
    weak var delegate: InfosCharacterTableHandlerDelegate?
    
    unowned let table: KDSTable
    
    var data: MarvelCharacterData!
    
    
    // Handlers
    let dispatcher = KFDispatcherQueue(provider: DispatchQueue.main)
    
        
    // MARK: - Construtores
    required init(table: KDSTable) {
        self.table = table
        super.init()
    }
    
    convenience init(table: KDSTable, data: MarvelCharacterData) {
        self.init(table: table)
        self.data = data
        link(with: table)
    }
    
    
    // MARK: - Configurações
    
    // MARK: Células
    private func createImageCell(at indexPath: IndexPath) -> InfosCharacterCell? {
        let cell = table.reusableCell(as: InfosCharacterCell.self, for: indexPath)
        cell?.setupCell(with: data)
        return cell
    }
    
    private func createDescriptionCell(at indexPath: IndexPath) -> KDSNativeCell? {
        let cell = table.reusableCell(as: KDSNativeCell.self, for: indexPath)
        let viewModel = KDSNativeCellVM(
            title: data.infos.title,
            description: data.infos.data,
            isInformative: true
        )
        cell?.setupCell(with: viewModel)
        cell?.backgroundColor = KDSColors.cellBackground
        return cell
    }
    
    private func createAppearanceCell(at indexPath: IndexPath) -> KDSNativeCell? {
        let cell = table.reusableCell(as: KDSNativeCell.self, for: indexPath)
        
        let infos = data.retriveAppearanceData(forRow: indexPath.row)
        let viewModel = KDSNativeCellVM(
            title: infos.title, description: infos.data, appearence: .lightMode
        )
        
        cell?.setupCell(with: viewModel)
        cell?.backgroundColor = KDSColors.cellBackground
        
        return cell
    }
    
    
    // MARK: Menu
    private func createPreview(for configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        guard let _ = configuration.identifier as? String else { return nil }

        let indexPath = IndexPath(row: 0, section: 0)
        guard let cell = table.cellForRow(at: indexPath) as? InfosCharacterCell else { return nil }

        let parameters = UIPreviewParameters()
        parameters.backgroundColor = .clear
        
        let preview = UITargetedPreview(view: cell.characterImage, parameters: parameters)
        return preview
    }
}


// MARK: - + Data Source
extension InfosCharacterTableHandler {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 2 ? 4 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dict: [Int: UITableViewCell?] = [
            0: createImageCell(at: indexPath),
            1: createDescriptionCell(at: indexPath),
            2: createAppearanceCell(at: indexPath),
        ]
        
        let cell = dict[indexPath.section] ?? UITableViewCell()
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 2 ? "APARIÇÃO" : nil
    }
}


// MARK: - + Delegate
extension InfosCharacterTableHandler {
    
    /* Footer */
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { nil }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 0 }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat { 0 }
    
    
    /* Header */
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? 44 : 22
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? 44 : 22
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 0 else { return }
        let cell = table.reusableCell(as: InfosCharacterCell.self, for: indexPath)
        cell?.backgroundColor = .clear
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    /* Menu */
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        guard indexPath.section == 0 else { return nil }
        
        let identifier = NSString(string: "\(indexPath.section)")
        return UIContextMenuConfiguration(identifier: identifier, previewProvider: nil) { suggestedActions in
            let menuIcon = KDSImage(asset: KDSIcons.share)
            let share = UIAction(title: "Compartilhar", image: menuIcon.imageCreated) { [weak self] action in
                let image = self?.data.image.image
                self?.delegate?.shareImage(image)
            }
            return UIMenu(title: "", children: [share])
        }
    }
    
    func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return createPreview(for: configuration)
    }
    
    func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return createPreview(for: configuration)
    }
}


// MARK: - + KDSCollectionHandler
extension InfosCharacterTableHandler {
    
    func registerCell(at table: KDSTable) {
        InfosCharacterCell.register(at: table)
    }
}
