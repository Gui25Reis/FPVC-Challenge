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


struct CharacterCellViewModel {
    var name: String
    var image: KDSImageViewModel
    var favoriteDate: String?
    
    init(name: String, image: KDSImageViewModel, favoriteDate: String? = nil) {
        self.name = name
        self.image = image
        self.favoriteDate = favoriteDate
    }
}



protocol CharacterCellDelegate: AnyObject {
    
    func didChangeFavoriteStatus(_ cell: CharacterCell)
}



class CharacterCell: UICollectionViewCell, KDSCollectionCellType, KDSViewCode {
    
    static let identifier = "IdCharacterCell"
    
    weak var delegate: CharacterCellDelegate?
    
    
    /* Componentes UI */
    lazy var imageView: KDSImageView = {
        let view = KDSImageView(loadingWithStyle: .medium)
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 7
        return view
    }()
    
    lazy var titleLabel: KDSLabel = {
        let label = KDSTitleWLabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var favoriteButton: KDSIconButton = {
        let image = KDSImage(asset: KDSIcons.favorite)
        let view = KDSIconButton(image: image)
        view.action = { [unowned self] _ in self.delegate?.didChangeFavoriteStatus(self) }
        return view
    }()
    
    
    // MARK: - Construtores
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) { nil }
    
    
    // MARK: - Ciclo de Vida
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard contentView.needsToCreateHierarchy else { return }
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.removeImage()
        imageView.showSpinner()
    }
    
    
    // MARK: - Encapsulamento
    public func setupCell(with data: MarvelCharacterData, image: KDSImage?) {
        titleLabel.text = data.name
        imageView.setupImage(with: image)
        updateFavoriteIcon(basedOn: data.isFavorited)
    }
    
    public func updateFavoriteIcon(basedOn status: Bool) {
        let icon = KDSIcons.favoriteIcon(basedOn: status)
        favoriteButton.image = KDSImage(asset: icon)
    }
    

    // MARK: - KDSViewCode
    func setupHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        let border: CGFloat = 10
        let buttonPadding: CGFloat = 6
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: border),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: border),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -border),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: border),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -border),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -border),
            
            
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor, constant: buttonPadding),
            favoriteButton.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -buttonPadding)
        ])
    }
    
    func additionalSetup() {
        setupUI()
    }
    
    func setupUI() {
        let color = KDSColors.cards
        backgroundColor = color.withAlphaComponent(0.5)
        layer.borderColor = color.cgColor
        
        layer.cornerRadius = 10
        layer.borderWidth = 3
    }
}
