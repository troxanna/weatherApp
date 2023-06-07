//
//  API.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 01.06.2023.
//

import Foundation
import CoreLocation

enum ApiType {
    case getWeatherByCityName(city: String)
    case getWeatherByCoordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }
    
    var headers: [String : String] {
            return ["Content-Type": "application/json"]
    }
    
    var path: String {
            return "weather"
    }
    
    var query: String {
        switch self {
        case .getWeatherByCityName(city: let city):
            return "q=\(city)&appid=\(appId)&units=metric"
        case .getWeatherByCoordinate(latitude: let latitude, longitude: let longitude):
            return "lat=\(latitude)&lon=\(longitude)&appid=\(appId)&units=metric"
        }
    }
    
    var request: URLRequest {
        let urlString = "\(baseURL)\(path)?\(query)"
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = "GET"
        return request
    }
}
