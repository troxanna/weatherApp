//
//  SupportData.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 31.05.2023.
//

import Foundation

enum Images: String {
    case background
    case search = "magnifyingglass.circle.fill"
    case cloudRain = "cloud.rain.fill"
    
    var text: String {
        switch self {
        case .background:
            return self.rawValue
        case .search:
            return self.rawValue
        case .cloudRain:
            return self.rawValue
        }
    }
}

enum Colors: String {
    case infoColor
    
    var text: String {
        switch self {
        case .infoColor:
            return self.rawValue
        }
    }
}
