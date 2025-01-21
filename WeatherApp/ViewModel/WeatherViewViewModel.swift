//
//  WeatherViewViewModel.swift
//  WeatherApp
//
//  Created by Manendra on 21/01/25.
//

import Foundation

class WeatherViewViewModel : ObservableObject {
    
    @Published var isSearchPressed = false
    
    init() {
        
    }
    
    func getDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let day = dateFormatter.string(from: Date())
        return day
    }
    
    func getDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        let date = dateFormatter.string(from: Date())
        return date
    }

}

