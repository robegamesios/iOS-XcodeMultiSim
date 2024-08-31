//
//  WeatherView-ViewModel.swift
//  SwiftUI-WeatherApp
//
//  Created by rob enriquez on 6/19/24.
//

import Foundation
import SwiftUI

extension WeatherView {
    @Observable final class ViewModel {
        
        private (set) var isNight = false
        var weatherResponse: WeatherResponse?
        
        func updateIsNight() {
            isNight.toggle()
        }
        
        func getWeather(city: String) async {
            let apiKey = "68734d0ae02de33873b24a287dbe6635"
            let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(apiKey)&units=imperial"
            let url = URL(string: urlString)!
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(WeatherResponse.self, from: data)
                    self.weatherResponse = decodedData
                    print("response: ", decodedData)
                } catch {
                    print("error occured: ", error);
                }
            }.resume()
        }
    }
}

struct WeatherResponse: Codable {
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let clouds: Clouds?
    let dt: Int?
    let sys: Sys?
    let timezone: Int?
    let id: Int?
    let name: String?
    let cod: Int?
}

// MARK: - Coord
struct Coord: Codable {
    let lon: Double
    let lat: Double
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case humidity
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Sys
struct Sys: Codable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Int
    let sunset: Int
}
