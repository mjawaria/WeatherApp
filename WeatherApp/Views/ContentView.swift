//
//  ContentView.swift
//  WeatherApp
//
//  Created by Manendra on 20/01/25.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    var forecastManager = ForecastManager()
    @State var weather: WeatherResponseBody?
    @State var forecast: ForecastResponseBody?
    @StateObject var mainViewModel = MainViewModel()
        
    var body: some View {
        VStack {
            if locationManager.location != nil {
                if weather != nil {
                    MainScreenView(
                        weather: self.$weather,
                        forecast: self.$forecast,
                        mainViewModel: mainViewModel
                    )
                    .onReceive(mainViewModel.$city){ newCity in
                        fetchWeather()
                        fetchForecast()
                        
                    }
                }
                else {
                    Text("Loading...")
                        .onAppear {
                            print("Location is available. Fetching weather...")
                            fetchWeather()
                            fetchForecast()
                        }
                }
            }
            else {
                if locationManager.isLoading {
                    LoadingView()
                }
                else {
                    Text("Location is nil or not available.")
                }
            }
        }
        .onAppear {
            print("Requesting location...")
            locationManager.requestLocation()
        }
    }
    
     func fetchWeather() {
        guard let location = locationManager.location else {
            print("Location is nil. Cannot fetch weather.")
            return
        }
        
            DispatchQueue.global().async {
                Task{
                    do {
                        let currentWeather = try await mainViewModel.city == "" ? weatherManager.getCurrentWeather(location: location) : weatherManager.getCurrentWeatherByCityName(city: mainViewModel.city)
                        DispatchQueue.main.async {
                            self.weather = currentWeather
                        }
                    } catch {
                        print("Error fetching weather:", error)
                    }

                }
            }
    }
     func fetchForecast() {
        guard let location = locationManager.location else {
            print("Location is nil. Cannot fetch forecast.")
            return
        }
        
            DispatchQueue.global().async {
                Task{
                    do {
                        let currentForecast = try await mainViewModel.city == "" ? forecastManager.getForecast(location: location) : forecastManager.getForecastByCity(city: mainViewModel.city)
                        DispatchQueue.main.async {
                            self.forecast = currentForecast
                        }
                    } catch {
                        print("Error fetching forecast:", error)
                    }

                }
            }
    }
}

#Preview {
    ContentView()
}
