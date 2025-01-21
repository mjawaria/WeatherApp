//
//  MainViewModel.swift
//  WeatherApp
//
//  Created by Manendra on 21/01/25.
//

import Foundation

class MainViewModel : ObservableObject {
    
    @Published var forecast = false
    @Published var isFav = false
    @Published var favouriteCities: [String] = UserDefaults.standard.stringArray(forKey: "FavouriteCities") ?? []
    @Published var showSheet = false
    @Published var locInput = false
    @Published var city = ""
    
    init() {
        
    }
    
    func addToFavourites(cityName: String) {
        if !favouriteCities.contains(cityName) {
            favouriteCities.append(cityName)
            UserDefaults.standard.set(favouriteCities, forKey: "FavouriteCities")
        }
    }
    
    func fetchFavouriteCities() -> [String] {
        return UserDefaults.standard.stringArray(forKey: "FavouriteCities") ?? []
    }
    
    func removeFromFavourites(cityName: String) {
        if let index = favouriteCities.firstIndex(of: cityName){
            favouriteCities.remove(at: index)
            UserDefaults.standard.set(favouriteCities, forKey: "FavouriteCities")
        }
    }
}
