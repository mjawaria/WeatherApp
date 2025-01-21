//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Manendra on 21/01/25.
//

import SwiftUI

struct WeatherView: View {
    
    var weather : WeatherResponseBody
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel = WeatherViewViewModel()
    @ObservedObject var mainViewModel : MainViewModel
    @State private var cityName : String = ""
    
    
    var body: some View {
        ZStack{
            ZStack {
                Color(Color(.white))
                    .ignoresSafeArea(.all)
                
                VStack {
                    HStack{
                        HStack{
                            Button{
                                mainViewModel.isFav = !mainViewModel.isFav
                                if mainViewModel.isFav {
                                    mainViewModel.removeFromFavourites(cityName: weather.name)
                                }
                                else{
                                    mainViewModel.addToFavourites(cityName: weather.name)
                                }
                            }label: {
                                Image(systemName: mainViewModel.favouriteCities.contains(weather.name) ? "star.fill" : "star")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 28)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                            }.padding(.trailing, 10)
                            Text(weather.name)
                                .font(.system(size: 32))
                                .bold()
                            
                        }
                        Spacer()
                        Menu{
                            Button {
                                mainViewModel.showSheet = true
                            }label: {
                                Text("Favourites")
                                Image(systemName: "star.square.on.square.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                            }
                            Button{
                                mainViewModel.locInput = true
                            }label: {
                                Text("Search")
                                Image(systemName: "magnifyingglass")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                            }
                            Button{
                                mainViewModel.city = ""
                            }label: {
                                Text("Current Location")
                                Image(systemName: "location.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                            }
                        }label: {
                            Image(systemName: "line.3.horizontal")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35)
                                .foregroundColor(colorScheme == .light ? .black : .white)
                        }
                        
                    }.padding()

                    VStack{
                        Text("\(String(format:"%.2f",weather.main.temp-273.15)) °C")
                            .font(.title)
                            .bold()
                        
                        Text("Feels like: \(String(format:"%.2f",weather.main.feels_like-273.15)) °C")
                        if let weathericon = IconMapper.iconMapper[weather.weather[0].main] {
                            Image(systemName: weathericon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120)
                                .padding(30)
                        }
                        else {
                            Image(systemName: "text.below.photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 120)
                                .padding(30)
                        }
  
                        Text(weather.weather[0].main)
                            .font(.title2)
                            .bold()
                        
                        let date = viewModel.getDate()
                        let day = viewModel.getDay()
                        Text("\(day), \(date)")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                    
                    Spacer()
                    
                    VStack {
                        HStack{
                            VStack{
                                Image(systemName: "wind")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45)
                                Text("\(weather.wind.speed)" + " m/s")
                            }
                            Spacer(minLength: 10)
                            VStack{
                                Image(systemName: "humidity")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45)
                                Text("\(weather.main.humidity)" + " %")
                            }
                            Spacer(minLength: 10)
                            VStack{
                                Image(systemName: "rectangle.compress.vertical")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45)
                                Text("\(weather.main.pressure)" + " hpa")
                            }
                        }.padding()
                        HStack{
                            VStack{
                                Image(systemName: "cloud.rain")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45)
                                Text("\(weather.rain?.d1h ?? 0)" + " mm")
                            }
                            Spacer(minLength: 10)
                            VStack{
                                Image(systemName: "icloud")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45)
                                    .padding(.vertical, 10)
                                Text("\( weather.cloud?.all ?? 0)" + " %")
                            }
                            Spacer(minLength: 10)
                            VStack{
                                Image(systemName: "snowflake")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 45)
                                Text("No info")
                            }
                        }.padding()
                    }.padding()
                    
                    Spacer()
                    Button{
                        mainViewModel.forecast = true
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(colorScheme == .light ? .black : .white)
                            Text("Get Forecast")
                                .foregroundColor(colorScheme == .light ? .white : .black)
                                .bold()
                        }.frame(width: 270, height: 50)
                    }.fixedSize()
                    
                }
                .padding()
                
            }
            .background(Color(.white))
            .sheet(isPresented: $mainViewModel.showSheet){
                FavouriteView(mainViewModel: mainViewModel)
                    .background(Color(.white))
            }

            if mainViewModel.locInput {
                VStack{
                    ZStack{
                        Color(.systemGray6).opacity(0.95)
                            .frame(width: (UIScreen.main.bounds.width - 20), height: 180)
                            .cornerRadius(10)
                        VStack(alignment: .trailing){
                            Button{
                                mainViewModel.locInput = false
                            }label: {
                                Image(systemName: "xmark.app")
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                                    .frame(width: 50)
                            }.padding(.trailing, 10)

                            HStack{
                                TextField("Enter City Name", text: $cityName)
                                    .keyboardType(.asciiCapable)
                                    .padding()
                                    .background(Color(.systemGray4))
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                    .padding()
                                    
                                Button{
                                    mainViewModel.locInput = false
                                    mainViewModel.city = cityName
                                }label:{
                                    Image(systemName: "magnifyingglass")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25)
                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                        .padding(.horizontal, 15)
                                }
                                .background(Color(.systemGray4).frame(width:50, height: 55).cornerRadius(10))
                            }.padding()
                             .background(Color(.systemGray6))
                             .cornerRadius(20.0)
                        }.padding()
                    }
                    
                    Spacer()
                }
            }
        }
    }
   
}

#Preview {
    WeatherView(
        weather:WeatherResponseBody(
            coord: WeatherResponseBody.CoordinatesResponse.init(lon: 19.0760, lat: 72.8777),
            weather: [WeatherResponseBody.WeatherResponse.init(
                id: 1,
                main: "Clouds",
                description: "Clouds",
                icon: "04d")],
            main: WeatherResponseBody.MainResponse.init(
                temp: 0,
                feels_like: 0,
                temp_min: 0,
                temp_max: 0,
                pressure: 0,
                humidity: 0),
            name: "Mumbai",
            wind: WeatherResponseBody.WindResponse.init(speed: 0, deg: 0),
            rain: WeatherResponseBody.Rain.init(d1h: 0.0),
            cloud: WeatherResponseBody.Clouds(all: 0),
            dt: 0
        ), mainViewModel: MainViewModel()
    )
}
