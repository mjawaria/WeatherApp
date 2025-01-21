//
//  WeatherResponseBody.swift
//  WeatherApp
//
//  Created by Manendra on 21/01/25.
//

import Foundation

struct WeatherResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    var rain : Rain?
    var cloud : Clouds?
    var dt : Int

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
    
    struct Rain : Decodable {
        var d1h : Double?
        
        enum CodingKeys : String, CodingKey{
            case d1h = "1h"
        }
    }
    
    
    struct Clouds : Decodable {
        var all : Int?
        
        enum CodingKeys : String, CodingKey {
            case all
        }
    }
}

extension WeatherResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
