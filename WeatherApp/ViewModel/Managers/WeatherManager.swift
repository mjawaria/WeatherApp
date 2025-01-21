//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Manendra on 21/01/25.
//

import Foundation
import CoreLocation

class WeatherManager: ObservableObject {
   
 
    func getCurrentWeather(location: CLLocation) async throws -> WeatherResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=20cf9e30f038ac871479751857817d4e") else {
            fatalError("Missing URL")
        }
 
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.connectionProxyDictionary = [:]
 
        let delegate = SessionDelegate()
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
 
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
 
            let decodedData = try JSONDecoder().decode(WeatherResponseBody.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
    
    func getCurrentWeatherByCityName(city: String) async throws -> WeatherResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=20cf9e30f038ac871479751857817d4e") else {
            fatalError("Missing URL")
        }
 
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.connectionProxyDictionary = [:]
 
        let delegate = SessionDelegate()
        let session = URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
 
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
 
            let decodedData = try JSONDecoder().decode(WeatherResponseBody.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}
