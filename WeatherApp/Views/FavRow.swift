//
//  FavRow.swift
//  WeatherApp
//
//  Created by Manendra on 21/01/25.
//

import SwiftUI

struct FavRow: View {
    
    @ObservedObject var mainViewModel : MainViewModel
    var cityName : String
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            Text(cityName)
                .onTapGesture {
                    mainViewModel.city = cityName
                    mainViewModel.showSheet = false
                }
            Spacer()
            Button(action: {
                mainViewModel.isFav = false
                mainViewModel.removeFromFavourites(cityName: cityName)
            }) {
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28)
                    .foregroundColor(colorScheme == .light ? .black : .white)
            }
        }
            
    }
}

#Preview {
    FavRow(mainViewModel: MainViewModel(), cityName: "My City")
}
