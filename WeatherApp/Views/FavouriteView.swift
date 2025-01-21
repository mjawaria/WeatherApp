//
//  FavouriteView.swift
//  WeatherApp
//
//  Created by Manendra on 21/01/25.
//

import SwiftUI

struct FavouriteView: View {
    @ObservedObject var mainViewModel: MainViewModel
    @Environment(\.colorScheme) var colorScheme
 
    var body: some View {
        VStack {
            Text("Favourite Cities")
                .font(.title)
                .bold()
                .padding()
                .background(Color(.white))
            
            List {
                ForEach(mainViewModel.favouriteCities, id: \.self) { cityName in
                    FavRow(mainViewModel: mainViewModel, cityName: cityName)
                        .listRowInsets(EdgeInsets())
                        .padding()
                        .background((Color(.blue).opacity(0.5)))
                        .cornerRadius(10)
                }
                .listRowSeparator(.hidden)
                .padding()
                .background(Color(.white))
                .listRowInsets(EdgeInsets())
            }
            .padding()
            .listRowInsets(EdgeInsets())
            .listStyle(PlainListStyle())
        }
        .background(Color(.white))    }
}

#Preview {
    FavouriteView(mainViewModel: MainViewModel())
}
