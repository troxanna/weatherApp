//
//  APIManager.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 03.06.2023.
//

import Foundation
import CoreLocation

class APIManager {
    static let shared = APIManager()
    
    func getCurrentWeather(for requestType: ApiType, completion: @escaping (_: () throws -> CurrentWeather) -> ()) {
        let request = requestType.request
        URLSession.shared.dataTask(with: request) { data, response, error in
            completion({
                if error != nil {
                    throw ErrorType.internalServerError
                }
                guard let data = data else { throw ErrorType.validationError }
                guard let currentWeather = try? self.parseJSON(data: data) else { throw ErrorType.validationError
                }
                return currentWeather
            })
        }.resume()
    }
}

//MARK: private functions
private extension APIManager {
    func parseJSON(data: Data) throws -> CurrentWeather? {
        guard let currentWeatherData = try? JSONDecoder().decode(WeatherData.self, from: data) else { throw ErrorType.validationError }
        guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
        return currentWeather
    }
}


