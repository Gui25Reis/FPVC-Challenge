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


protocol InfosCharacterCellDelegate: AnyObject {
    
    func shareImage(_ image: UIImage?)
}


class InfosCharacterCell: UITableViewCell, KDSTableCellType, KDSViewCode {
        
    static let identifier = "IdCharacterCell"
    
    weak var delegate: InfosCharacterCellDelegate?
    
    
    /* Componentes UI */
    lazy var characterImage: KDSImageView = {
        let view = KDSImageView(loadingWithStyle: .medium)
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var titleLabel: KDSLabel = {
        let label = KDSBiggerLabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    
    // MARK: - Construtores
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
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
        characterImage.removeImage()
        characterImage.showSpinner()
    }
    
    
    // MARK: - Encapsulamento
    public func setupCell(with data: MarvelCharacterData) {
        titleLabel.text = data.name
        characterImage.setupImage(with: data.image.image)
    }
    

    // MARK: - KDSViewCode
    func setupHierarchy() {
        contentView.addSubview(characterImage)
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        let border: CGFloat = 10
        
        NSLayoutConstraint.activate([
            characterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: border),
            characterImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            characterImage.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8),
            characterImage.heightAnchor.constraint(equalTo: characterImage.widthAnchor),
            
            
            titleLabel.topAnchor.constraint(equalTo: characterImage.bottomAnchor, constant: 24),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: border),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -border),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -border),
        ])
    }
    
    func additionalSetup() {
        backgroundColor = .clear
    }
}
