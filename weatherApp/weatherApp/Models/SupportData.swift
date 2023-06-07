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
    
    enum WeatherIcons: String {
        case rain = "cloud.rain.fill"
        case bolt = "cloud.bolt.rain.fill"
        case drizzle = "cloud.drizzle.fill"
        case snow = "cloud.snow.fill"
        case smoke = "smoke.fill"
        case sun = "sun.min.fill"
        case cloud = "cloud.fill"
        case none = "nosign"
        
        var text: String {
            return self.rawValue
        }
    }
    
    var text: String {
        return self.rawValue
    }
}

enum Colors: String {
    case infoColor
    
    var text: String {
        return self.rawValue
    }
}


