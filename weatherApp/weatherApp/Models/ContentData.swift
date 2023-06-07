//
//  ContentData.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 03.06.2023.
//

import Foundation

enum AlertControllerData {
    case search
    
    var title: String {
        switch self {
        case .search:
            return ("Enter city name")
        }
    }
    
    var message: String? {
        switch self {
        case .search:
            return nil
        }
    }
    
    enum TextFieldData {
        case city
        
        var placeholder: String? {
            let cities = ["San Francisco", "Moscow", "New York", "Stambul", "Viena"]
            
            switch self {
            case .city:
                return cities.randomElement()
            }
        }
        
    }
    
    enum AlertActionData {
        case search
        case cancel
        
        var title: String {
            switch self {
            case .search:
                return "Search"
            case .cancel:
                return "Cancel"
            }
        }
    }
}
