/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


/// Os tipos que estão de acordo com esse protocolo são Views que são criadas por view code!
///
/// O objetivo desse contrato eh principalmente a padronização da construção das telas
public protocol KDSViewCode: UIView {
    
    /// Configurações gerais da view
    func setupView()
    
    /// Adiciona os elementos (Views) na tela, criando a hierarquia de views
    func setupHierarchy()
    
    /// Configura as constraints do componentes da tela
    func setupConstraints()
    
    /// Configura a acessibilidade dos componentes
    func setupAccessibility()
    
    /// Configuraçòes gerais
    func additionalSetup()
}


public extension KDSViewCode {
    
    func setupView() {
        setupHierarchy()
        setupConstraints()
        setupAccessibility()
        additionalSetup()
    }
    
    func setupAccessibility() {
        /* Mantendo implementação opcional */
    }
    
    func additionalSetup() {
        /* Mantendo implementação opcional */
    }
}
