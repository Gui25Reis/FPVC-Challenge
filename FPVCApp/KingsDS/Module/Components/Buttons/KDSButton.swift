/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit
import KingsFoundation


/// Botão costumizado
open class KDSButton: UIButton, KDSComponent {
    
    /// Boleano que indica se a ação do botão já foi configurada no botão
    private var didSetupAction = false
    
    
    public var defaultAttributes: StringAttributes?
    
    /// Cor principal do botão
    var mainColor: UIColor? {
        didSet { setupMainColor() }
    }
    
    /// Texto do botão
    public var title: String? {
        set(value) { setTitle(value, for: .normal) }
        get { title(for: .normal) }
    }
    
    /// Texto do tipo de atribuição
    public var atributtedTitle: String? {
        set(value) {
            let text = createAttributedString(value, attributes: defaultAttributes)
            setAttributedTitle(text, for: .normal)
        }
        get {
            attributedTitle(for: .normal)?.string
        }
    }
    
    /// Cor do texto do botão
    public var titleColor: UIColor? {
        set(value) { setTitleColor(value, for: .normal) }
        get { titleColor(for: .normal) }
    }
    
    /// Ação do botão
    public var action: ((UIButton) -> Void)? {
        didSet { setupAction() }
    }
    
    
    /* MARK: - Construtor */
    
    public init() {
        super.init(frame: .zero)
        self.initialSetup()
    }
    
    public convenience init(title: String) {
        self.init()
        self.title = title
    }
    
    public convenience init(with viewModel: KDSButtonViewModel?) {
        self.init()
        setup(with: viewModel)
    }
            
    public required init?(coder: NSCoder) { nil }
    
    deinit {
        action = nil
    }
    
    
    /* MARK: - Encapsulamento */
    
    public func setup(with viewModel: KDSButtonViewModel?) {
        self.title = viewModel?.title
        self.action = viewModel?.action
    }
    
    public func createAttributedString(_ text: String?, attributes: StringAttributes? = nil) -> NSAttributedString {
        let mutable = NSMutableAttributedString(string: text ?? "", attributes: attributes)
        return NSAttributedString(attributedString: mutable)
    }
    
    
    /* MARK: - Configurações */
        
    /// Configura as cores a partir da cor principal
    private func setupMainColor() {
        guard let mainColor else { return }
        
        backgroundColor = mainColor.withAlphaComponent(0.2)
        setTitleColor(mainColor, for: .normal)
        tintColor = mainColor
    }
    
    
    private func setupAction() {
        if action == nil {
            removeTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            didSetupAction = false
            return
        }
        
        guard didSetupAction == false else { return }
        addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc private func buttonAction() {
        action?(self)
    }
    
    
    /* MARK: - KDSComponent */
    
    public func initialSetup() {
        activateConstraints()
    }
}
