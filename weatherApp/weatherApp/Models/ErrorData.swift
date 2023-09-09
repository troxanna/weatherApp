//
//  ErrorData.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 07.06.2023.
//

import Foundation

enum ErrorType: Error {
    case validationError
    case internalServerError
    case cityNotFound (_ city: String?)
    case networkError
    case locationDisabled
    
    var message: String {
        switch self {
        case .locationDisabled:
            return "Службы определения местоположения\nне включены"
        case .networkError:
            return "Нет подключения к интернету"
        case .cityNotFound (let city):
            return "City \(city ?? "") not found"
        default:
            return "Error connecting to server"
        }
    }
}
