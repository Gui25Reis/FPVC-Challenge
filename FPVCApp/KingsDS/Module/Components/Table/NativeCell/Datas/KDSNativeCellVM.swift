/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


/// Modelos de dados para célula padrão das tebles
public struct KDSNativeCellVM {
    
    /// Texto principal, que fica na esquerda
    public let title: String
    
    /// Texto secundário, que fica na direita
    public var message: String?
    
    /// Imagem que acompanha o texto principal
    public var leftImage: UIImage?
    
    /// Ícone direito (no fim da célula) padrão da célula
    public var rightIcon: KDSNativeCellIcons?
    
    /// Boleano que indica se á célula possui o seu laytou informativo, tendo apenas o título e a mensagem abaixo
    public var isInformative: Bool
    
    
    public var appearence: KDSDeviceAppearence
    
    
    // MARK: - Construtores
    public init(title: String, description: String, leftImage: UIImage? = nil, rightIcon: KDSNativeCellIcons? = nil, isInformative: Bool = false, appearence: KDSDeviceAppearence = .automatic) {
        self.title = title
        self.message = description
        self.leftImage = leftImage
        self.rightIcon = rightIcon
        self.isInformative = isInformative
        self.appearence = appearence
    }
    
    
    public func makeTableContent(with content: inout UIListContentConfiguration) {
        content.image = leftImage
        content.text = title
        content.secondaryText = message
    }
}
