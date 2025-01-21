//
//  ForecastManager.swift
//  WeatherApp
//
//  Created by Manendra on 20/01/25.
//

import Foundation
import CoreLocation

class ForecastManager: ObservableObject {
    func getForecast(location: CLLocation) async throws -> ForecastResponseBody {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=da92ae08f9411eea2df794bff5b413e3") else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let deletage = SessionDelegate()
        let session = URLSession(configuration: .default, delegate: deletage, delegateQueue: nil)
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let decodeData = try JSONDecoder().decode(ForecastResponseBody.self, from: data)
            return decodeData
            
        } catch {
            print("Forecase Error: \(error)")
            throw error
        }
    }
    
    func getForecastByCity(city: String) async throws -> ForecastResponseBody {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=da92ae08f9411eea2df794bff5b413e3") else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let deletage = SessionDelegate()
        let session = URLSession(configuration: .default, delegate: deletage, delegateQueue: nil)
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let decodeData = try JSONDecoder().decode(ForecastResponseBody.self, from: data)
            return decodeData
            
        } catch {
            print("Forecase Error: \(error)")
            throw error
        }
        
        
    }
    
}
