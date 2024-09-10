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


open class KDSSearchController: UISearchController, UISearchBarDelegate, UISearchControllerDelegate {
    
    public weak var searchDelegate: KDSSearchDelegate?
    
    
    final public var infosColor: UIColor? {
        didSet { setupTextsAndIconsColor() }
    }
    
    final public var accentColor: UIColor? {
        didSet { setupAccentColor() }
    }
    
    
    // MARK: - Construtores
    
    public override init(searchResultsController: UIViewController?) {
        super.init(searchResultsController: searchResultsController)
        setupHandler()
    }
    
    public convenience init() {
        self.init(searchResultsController: nil)
    }
    
    public required init?(coder: NSCoder) { nil }
    
    
    
    // MARK: - Encapsulamento
    
    public func setupPlaceHolder(text: String, color: UIColor? = nil) {
        searchBar.searchTextField.setupPlaceHolder(text: text, color: color)
    }
    
    
    // MARK: - Configurações
    
    /// Configurações inicias da classe
    private func setupHandler() {
        delegate = self
        searchBar.delegate = self
        
        obscuresBackgroundDuringPresentation = false
    }
    
    // MARK: Colors
    private func setupTextsAndIconsColor() {
        searchBar.searchTextField.setupTextsAndIconsColor(for: infosColor)
    }
    
    private func setupAccentColor() {
        searchBar.searchTextField.backgroundColor = accentColor
    }
    
    private func updateColors() {
        setupTextsAndIconsColor()
        setupAccentColor()
    }
}


// MARK: - + UISearchBarDelegate
public extension KDSSearchController {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        searchDelegate?.searchWith(data: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchDelegate?.searchCanceled()
    }
}


// MARK: - + UISearchControllerDelegate
public extension KDSSearchController {
    
    func presentSearchController(_ searchController: UISearchController) {
        updateColors()
        searchDelegate?.searchDidTrigger(self)
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        searchDelegate?.willPresentSearch(self)
    }

    func didPresentSearchController(_ searchController: UISearchController) {
        searchDelegate?.didPresentSearch(self)
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        searchDelegate?.willDismissSearch(self)
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        searchDelegate?.didDismissSearch(self)
    }
}
