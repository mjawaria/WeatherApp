//
//  SearchView.swift
//  WeatherApp
//
//  Created by Manendra on 21/01/25.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = WeatherViewViewModel()
    
    var body: some View {
        if viewModel.isSearchPressed {
            Text("Searching")
        }
    }
}

#Preview {
    SearchView()
}
