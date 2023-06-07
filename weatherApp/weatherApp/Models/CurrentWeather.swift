//
//  CurrentWeather.swift
//  weatherApp
//
//  Created by Anastasia Nevodchikova on 03.06.2023.
//

import Foundation

struct CurrentWeather {
    let cityName: String
    
    let temperature: Double
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    let feelsLikeTemperature: Double
    var feelsLikeTemperatureString: String {
        return String(format: "%.0f", feelsLikeTemperature)
    }
    
    let conditionCode: Int
    var systemIconNameString: String {
        switch conditionCode {
        case 200...232:
            return Images.WeatherIcons.bolt.text
        case 300...321:
            return Images.WeatherIcons.drizzle.text
        case 500...521:
            return Images.WeatherIcons.rain.text
        case 600...622:
            return Images.WeatherIcons.snow.text
        case 701...781:
            return Images.WeatherIcons.smoke.text
        case 800:
            return Images.WeatherIcons.sun.text
        case 801...804:
            return Images.WeatherIcons.cloud.text
        default:
            return Images.WeatherIcons.none.text
        }
    }
    
    init? (currentWeatherData: WeatherData) {
        cityName = currentWeatherData.name
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        conditionCode = currentWeatherData.weather.first!.id
    }
}
