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

// MARK: - KDSBiggerLabel
open class KDSBiggerLabel: KDSLabel {
    
    override var defaultFontConfig: KDSFontVM? {
        KDSFontVM(size: 32, weight: .semibold, color: .black)
    }
}


// MARK: - KDSTitleLabel
open class KDSTitleLabel: KDSLabel {
    
    override var defaultFontConfig: KDSFontVM? {
        KDSFontVM(size: 18, weight: .bold, color: .black)
    }
}


// MARK: - KDSBodyLabel
open class KDSBodyLabel: KDSLabel {
    
    override var defaultFontConfig: KDSFontVM? {
        KDSFontVM(size: 16, weight: .regular, color: .black)
    }
}


// MARK: - KDSInfoLabel
open class KDSInfoLabel: KDSLabel {
    
    override var defaultFontConfig: KDSFontVM? {
        KDSFontVM(size: 16, weight: .regular, color: .systemGray3)
    }
}


// MARK: - KDSSecondaryTitleLabel
open class KDSSecondaryTitleLabel: KDSLabel {
    
    override var defaultFontConfig: KDSFontVM? {
        KDSFontVM(size: 14, weight: .medium, color: .black)
    }
}


// MARK: - KDSTertiaryTitleLabel
open class KDSTertiaryTitleLabel: KDSLabel {
    
    override var defaultFontConfig: KDSFontVM? {
        KDSFontVM(size: 12, weight: .medium, color: .black)
    }
}




// MARK: - KDSBiggerWLabel
open class KDSBiggerWLabel: KDSLabel {
    
    override var defaultFontConfig: KDSFontVM? {
        KDSFontVM(size: 32, weight: .semibold, color: .white)
    }
}


// MARK: - KDSTitleWLabel
open class KDSTitleWLabel: KDSLabel {
    
    override var defaultFontConfig: KDSFontVM? {
        KDSFontVM(size: 18, weight: .bold, color: .white)
    }
}


// MARK: - KDSBodyWLabel
open class KDSBodyWLabel: KDSLabel {
    
    override var defaultFontConfig: KDSFontVM? {
        KDSFontVM(size: 16, weight: .regular, color: .white)
    }
}


// MARK: - KDSInfoWLabel
open class KDSInfoWLabel: KDSLabel {
    
    override var defaultFontConfig: KDSFontVM? {
        KDSFontVM(size: 16, weight: .regular, color: .white)
    }
}


// MARK: - KDSSecondaryTitleWLabel
open class KDSSecondaryTitleWLabel: KDSLabel {
    
    override var defaultFontConfig: KDSFontVM? {
        KDSFontVM(size: 14, weight: .medium, color: .white)
    }
}


// MARK: - KDSTertiaryTitleWLabel
open class KDSTertiaryTitleWLabel: KDSLabel {
    
    override var defaultFontConfig: KDSFontVM? {
        KDSFontVM(size: 12, weight: .medium, color: .white)
    }
}
