//
//  WeatherData.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 03.06.2023.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
}
