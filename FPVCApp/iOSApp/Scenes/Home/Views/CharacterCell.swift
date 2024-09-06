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


class CharacterCell: UICollectionViewCell, KDSCollectionCellType, KDSViewCode {
    
    static let identifier = "IdCharacterCell"
    
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
    public func setupCell(with data: MarvelCharacterData, image: UIImage?) {
        titleLabel.text = data.name
        imageView.prepare(image: image)
    }
    

    // MARK: - KDSViewCode
    func setupHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        let border: CGFloat = 10
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: border),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: border),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -border),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: border),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -border),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -border),
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
