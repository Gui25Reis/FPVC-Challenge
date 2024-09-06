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


open class KDSCollectionLayout: UICollectionViewFlowLayout {
    
    final public var cellSize: CGSize = .zero {
        didSet { itemSize = cellSize }
    }
    
    final public var horizontalSpace: CGFloat = .zero {
        didSet { minimumInteritemSpacing = horizontalSpace }
    }
    
    final public var verticalSpace: CGFloat = .zero {
        didSet { minimumLineSpacing = verticalSpace }
    }
    
    final public var beetweenSpace: CGFloat = .zero {
        didSet {
            horizontalSpace = beetweenSpace
            verticalSpace = beetweenSpace
        }
    }
}
