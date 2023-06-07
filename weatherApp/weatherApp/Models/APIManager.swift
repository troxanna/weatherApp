//
//  APIManager.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 03.06.2023.
//

import Foundation
import CoreLocation
import Alamofire

class APIManager {
    static let shared = APIManager()
    
    func getCurrentWeather(for requestType: ApiType, completion: @escaping (_: () throws -> CurrentWeather) -> ()) {
        AF.request(requestType.url, method: requestType.method, headers: requestType.headers)
        .validate()
        .responseDecodable(of: WeatherData.self) { data in
            completion({
                switch data.result {
                case .success(let value):
                    guard let currentWeather = CurrentWeather(currentWeatherData: value) else{ throw ErrorType.unexpectedError }
                    return currentWeather
                case .failure(let error):
                    if error.responseCode == 404 {
                        throw ErrorType.cityNotFound
                    } else if error.responseCode == 400 {
                        throw ErrorType.validationError
                    } else {
                        throw ErrorType.internalServerError
                    }
                }
            })
        }
    }
}
