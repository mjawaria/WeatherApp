//
//  ForecastResponseBody.swift
//  WeatherApp
//
//  Created by Manendra on 20/01/25.
//

import Foundation

struct ForecastResponseBody: Decodable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
    
    struct City: Decodable {
        let id: Int
        let name: String
        let coord: Coord
        let country: String
        let population, timezone, sunrise, sunset: Int
        
        struct Coord: Decodable {
            let lat, lon: Double
        }
    }
    
    struct List: Decodable {
        let dt: Int
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let pop: Double
        let rain: Rain?
        let sys: Sys
        let dtTxt: String

        enum CodingKeys: String, CodingKey {
            case dt, main, weather, clouds, wind, visibility, pop, rain, sys
            case dtTxt = "dt_txt"
        }
        
        struct Clouds: Decodable {
            let all: Int
        }

        struct Main: Decodable {
            let temp, feelsLike, tempMin, tempMax: Double
            let pressure, seaLevel, grndLevel, humidity: Int
            let tempKf: Double

            enum CodingKeys: String, CodingKey {
                case temp
                case feelsLike = "feels_like"
                case tempMin = "temp_min"
                case tempMax = "temp_max"
                case pressure
                case seaLevel = "sea_level"
                case grndLevel = "grnd_level"
                case humidity
                case tempKf = "temp_kf"
            }
        }

        struct Rain: Decodable {
            let the3H: Double

            enum CodingKeys: String, CodingKey {
                case the3H = "3h"
            }
        }

        struct Sys: Decodable {
            let pod: String
        }

        struct Weather: Decodable {
            let id: Int
            let main, description, icon: String
        }

        struct Wind: Decodable {
            let speed: Double
            let deg: Int
            let gust: Double
        }
    }
}
