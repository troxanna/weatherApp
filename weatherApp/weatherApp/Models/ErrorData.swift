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
    case networkError
    case cityNotFound
    case locationDisabled
    case unexpectedError
    
    var message: String {
        switch self {
        case .locationDisabled:
            return "Службы определения местоположения\nне включены"
        case .networkError:
            return "Нет подключения к интернету"
        case .cityNotFound:
            return "Не удалось найти город"
        default:
            return "Ошибка подключения к серверу"
        }
    }
}
