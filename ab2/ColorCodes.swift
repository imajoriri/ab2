//
//  ColorCodes.swift
//  ab2
//
//  Created by imajo-takeyuki on 2020/02/26.
//  Copyright © 2020 Imajo Takeyuki. All rights reserved.
//

import SwiftUI

enum ColorCode {
    case main
    
    func color() -> Color {
        switch self {
        case .main:
            return Color(red: 0, green: 178/255, blue: 39/255)
        }
    }
    
    func uiColor() -> UIColor {
        switch self {
        case .main:
            return UIColor(red: 0, green: 178/255, blue: 39/255, alpha: 100)
        }
    }
}
