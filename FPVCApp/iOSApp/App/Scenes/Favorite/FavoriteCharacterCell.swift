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


class FavoriteCharacterCell: UICollectionViewCell, KDSCollectionCellType, KDSViewCode {
    
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
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var dateLabel: KDSLabel = {
        let label = KDSBodyWLabel()
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
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
    public func setupCell(with data: MarvelCharacterData) {
        titleLabel.text = data.name
        
        let icon = KDSImage(asset: KDSIcons.favoriteSelected)
        dateLabel.setText("$@ \(data.favoritedDate)", icon: icon)
        imageView.setupImage(with: data.image.image)
    }
    
    
    // MARK: - KDSViewCode
    func setupHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
    }
    
    func setupConstraints() {
        let border: CGFloat = 10
        let vSpace: CGFloat = 8
        let center: CGFloat = 2
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: border),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: border),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -border),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: vSpace),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -border),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -center),
            
            
            dateLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: vSpace),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -border),
            dateLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: center)
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
