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


enum KDSNativeColors {
    case label
    case secondaryLabel
    case tertiaryLabel
    case quaternaryLabel
    case systemBackground
    case secondarySystemBackground
    case tertiarySystemBackground
    case systemBlue
    case systemBrown
    case systemPink
    case systemGreen
    case systemIndigo
    case systemOrange
    case systemPurple
    case systemRed
    case systemTeal
    case systemYellow
    case systemGray
    
    
    static func makeColor(for color: Self, with appearence: KDSDeviceAppearence) -> UIColor? {
        return switch appearence {
        case .darkMode: color.darkColor
        case .lightMode: color.lightColor
        case .automatic: color.system
        }
    }
    
    
    // MARK: Light
    var lightColor: UIColor {
        return switch self {
        case .label:
            UIColor(hex: "#000000", alpha: 1.0)
        case .secondaryLabel:
            UIColor(hex: "#3C3C43", alpha: 0.6)
        case .tertiaryLabel:
            UIColor(hex: "#3C3C43", alpha: 0.3)
        case .quaternaryLabel:
            UIColor(hex: "#3C3C43", alpha: 0.18)
        case .systemBackground:
            UIColor(hex: "#FFFFFF", alpha: 1.0)
        case .secondarySystemBackground:
            UIColor(hex: "#F2F2F7", alpha: 1.0)
        case .tertiarySystemBackground:
            UIColor(hex: "#FFFFFF", alpha: 1.0)
        case .systemBlue:
            UIColor(hex: "#007AFF", alpha: 1.0)
        case .systemBrown:
            UIColor(hex: "#A2845E", alpha: 1.0)
        case .systemPink:
            UIColor(hex: "#FF2D55", alpha: 1.0)
        case .systemGreen:
            UIColor(hex: "#34C759", alpha: 1.0)
        case .systemIndigo:
            UIColor(hex: "#5856D6", alpha: 1.0)
        case .systemOrange:
            UIColor(hex: "#FF9500", alpha: 1.0)
        case .systemPurple:
            UIColor(hex: "#AF52DE", alpha: 1.0)
        case .systemRed:
            UIColor(hex: "#FF3B30", alpha: 1.0)
        case .systemTeal:
            UIColor(hex: "#30B0C7", alpha: 1.0)
        case .systemYellow:
            UIColor(hex: "#FFCC00", alpha: 1.0)
        case .systemGray:
            UIColor(hex: "#8E8E93", alpha: 1.0)
        }
    }
    
    
    // MARK: Dark
    var darkColor: UIColor {
        return switch self {
        case .label:
            UIColor(hex: "#FFFFFF", alpha: 1.0)
        case .secondaryLabel:
            UIColor(hex: "#EBEBF5", alpha: 0.6)
        case .tertiaryLabel:
            UIColor(hex: "#EBEBF5", alpha: 0.3)
        case .quaternaryLabel:
            UIColor(hex: "#EBEBF5", alpha: 0.18)
        case .systemBackground:
            UIColor(hex: "#000000", alpha: 1.0)
        case .secondarySystemBackground:
            UIColor(hex: "#1C1C1E", alpha: 1.0)
        case .tertiarySystemBackground:
            UIColor(hex: "#2C2C2E", alpha: 1.0)
        case .systemBlue:
            UIColor(hex: "#0A84FF", alpha: 1.0)
        case .systemBrown:
            UIColor(hex: "#AC8E68", alpha: 1.0)
        case .systemPink:
            UIColor(hex: "#FF375F", alpha: 1.0)
        case .systemGreen:
            UIColor(hex: "#30D158", alpha: 1.0)
        case .systemIndigo:
            UIColor(hex: "#5E5CE6", alpha: 1.0)
        case .systemOrange:
            UIColor(hex: "#FF9F0A", alpha: 1.0)
        case .systemPurple:
            UIColor(hex: "#BF5AF2", alpha: 1.0)
        case .systemRed:
            UIColor(hex: "#FF453A", alpha: 1.0)
        case .systemTeal:
            UIColor(hex: "#40CBE0", alpha: 1.0)
        case .systemYellow:
            UIColor(hex: "#FFD60A", alpha: 1.0)
        case .systemGray:
            UIColor(hex: "#636366", alpha: 1.0)
        }
    }
    
    
    // MARK: System
    var system: UIColor {
        return switch self {
        case .label: .label
        case .secondaryLabel: .secondaryLabel
        case .tertiaryLabel: .tertiaryLabel
        case .quaternaryLabel: .quaternaryLabel
        case .systemBackground: .systemBackground
        case .secondarySystemBackground: .secondarySystemBackground
        case .tertiarySystemBackground: .tertiarySystemBackground
        case .systemBlue: .systemBlue
        case .systemBrown: .systemBrown
        case .systemPink: .systemPink
        case .systemGreen: .systemGreen
        case .systemIndigo: .systemIndigo
        case .systemOrange: .systemOrange
        case .systemPurple: .systemPurple
        case .systemRed: .systemRed
        case .systemTeal: .systemTeal
        case .systemYellow: .systemYellow
        case .systemGray: .systemGray
        }
    }
}
