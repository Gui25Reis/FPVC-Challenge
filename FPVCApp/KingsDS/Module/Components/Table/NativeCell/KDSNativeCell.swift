/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit
import KingsFoundation


open class KDSNativeCell: UITableViewCell, KDSTableCellType, KDSComponent, KDSViewCode {
        
    open class var identifier: String { "IdKDSNativeCell" }
    
    /* Overrides */
    public override var needsToCreateHierarchy: Bool {
        contentView.needsToCreateHierarchy && (cellData?.isInformative).isTrue
    }
    
    
    /* Componentes UI */
    lazy var titleLabel: KDSLabel = {
        let label = KDSSecondaryTitleLabel()
        label.text = cellData?.title
        label.numberOfLines = 1
        return label
    }()
    
    lazy var infoLabel: KDSLabel = {
        let label = KDSBodyLabel()
        label.text = cellData?.message
        label.autoAdjustBasedOnText()
        return label
    }()
    
    lazy var labelsStack: KDSStack = {
        let view = KDSStack()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .equalSpacing
        return view
    }()
    
    
    /* Outros */
     
    var cellData: KDSNativeCellVM?
    
    public var hasRightIcon = false
    
    public var contentAppearenceColor: KDSDeviceAppearence = .automatic
    
    /// Espaço lateral direito da célula
    ///
    /// Caso precise colocar uma view de acordo com o espaçamento
    public var rightLateralSpace: CGFloat {
        hasRightIcon ? 8 : 16
    }
    
    
    // MARK: - Construtor
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        initialSetup()
    }
    
    public required init?(coder: NSCoder) { nil }

    
    
    // MARK: - Encapsulamento
    public func setupCell(with data: KDSNativeCellVM) {
        cellData = data
        contentAppearenceColor = data.appearence
        
        data.isInformative
        ? setupInformativeCell()
        : setupDataAtContent()
    }
    
    private func setupDataAtContent() {
        var content = defaultContentConfiguration()
        cellData?.makeTableContent(with: &content)
        
        updateContentColorsIfNeeded(&content)
        contentConfiguration = content
        setupRightIconIfNeeded(for: cellData?.rightIcon)
    }
    
    private func setupInformativeCell() {
        var shouldSetupView: Bool {
            !needsToCreateHierarchy && !labelsStack.hasSuperview
        }
        
        if shouldSetupView { setupView() }
        guard labelsStack.hasSuperview else { return }
        
        titleLabel.text = cellData?.title
        infoLabel.text = cellData?.message
    }
    
    
    
    // MARK: - Override
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard needsToCreateHierarchy else { return }
        setupView()
    }
    
    open override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    
    // MARK: - KDSComponent
    final public func initialSetup() {
        backgroundColor = .clear
    }
    
    
    // MARK: - Configurações
    private func clearCell() {
        hasRightIcon = false
        contentConfiguration = defaultContentConfiguration()
        accessoryView = nil
        accessoryType = .none
        
        backgroundColor = .clear
        
        guard labelsStack.hasSuperview else { return }
        labelsStack.removeFromSuperview()
        titleLabel.removeFromSuperview()
        infoLabel.removeFromSuperview()
    }
    
    
    /// Configura a imagem da direita da célula de acordo com a configuração passada
    /// - Parameter icon: tipo de ícone
    private func setupRightIconIfNeeded(for icon: KDSNativeCellIcons?) {
        guard let icon else { return }
        switch icon {
        case .chevron:
            accessoryType = .disclosureIndicator
        default:
            accessoryView = nil
        }
        hasRightIcon = true
    }
    
    private func updateContentColorsIfNeeded(_ content: inout UIListContentConfiguration) {
        guard (cellData?.isInformative).isFalse else { return }
        
        content.textProperties.color = getNativeColor(for: .label) ?? .init()
        content.secondaryTextProperties.color = getNativeColor(for: .secondaryLabel) ?? .init()
    }
    
    private func getNativeColor(for color: KDSNativeColors) -> UIColor? {
        KDSNativeColors.makeColor(for: color, with: contentAppearenceColor)
    }
    
    // MARK: - KDSViewCode
    public func setupHierarchy() {
        labelsStack.addViewInStack(titleLabel)
        labelsStack.addViewInStack(infoLabel)
        contentView.addSubview(labelsStack)
    }
    
    public func setupConstraints() {
        let constraints = labelsStack.strechToBounds(of: contentView, space: 10)
        NSLayoutConstraint.activate(constraints)
    }
}
