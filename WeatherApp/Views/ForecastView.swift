//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Manendra on 21/01/25.
//

import SwiftUI

struct ForecastView: View {
    
    @ObservedObject var mainViewModel : MainViewModel
    @Environment(\.colorScheme) var colorScheme
    var forecast : ForecastResponseBody
    
    var body: some View {
        NavigationView{
            ZStack{
                Color(.white)
                    .ignoresSafeArea(.all)
                VStack{
                    List(forecast.list, id: \.dt) {forecast in
                        ForecastCardView(
                            date_text: forecast.dtTxt,
                            temp: forecast.main.temp,
                            feelsLike: forecast.main.feelsLike,
                            weather: forecast.weather[0].main,
                            desc: forecast.weather[0].description,
                            wind: forecast.wind.speed,
                            humidity: forecast.main.humidity,
                            pressure: forecast.main.pressure)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                    }
                    .padding()
                    .listStyle(PlainListStyle())
                    .background(Color(.white))
                    .listRowInsets(EdgeInsets())
                    
                }
                .background(Color(.white))
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button{
                            mainViewModel.forecast = false
                        }label: {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(colorScheme == .light ? .black : .white)
                        }.padding()
                        
                    }
                }
            }
        }
        
    }
}

#Preview {
    ForecastView(
        mainViewModel: MainViewModel(),
        forecast: ForecastResponseBody(
            cod: "cod",
            message: 0,
            cnt: 0,
            list: [ForecastResponseBody.List(
                dt: 0,
                main: ForecastResponseBody.List.Main(
                    temp: 0.0,
                    feelsLike: 0.0,
                    tempMin: 0.0,
                    tempMax: 0.0,
                    pressure: 0,
                    seaLevel: 0,
                    grndLevel: 0,
                    humidity: 0,
                    tempKf: 0.0),
                weather: [ForecastResponseBody.List.Weather(
                    id: 0,
                    main: "main",
                    description: "Description",
                    icon: "icon")],
                clouds: ForecastResponseBody.List.Clouds.init(all: 0),
                wind: ForecastResponseBody.List.Wind.init(
                    speed: 0.0,
                    deg: 0,
                    gust: 0.0),
                visibility: 0,
                pop: 0.0,
                rain: ForecastResponseBody.List.Rain.init(the3H: 0.0),
                sys: ForecastResponseBody.List.Sys.init(pod: "pod"),
                dtTxt: "2022-08-30 18:00:00"),
                   ForecastResponseBody.List(
                       dt: 0,
                       main: ForecastResponseBody.List.Main(
                           temp: 0.0,
                           feelsLike: 0.0,
                           tempMin: 0.0,
                           tempMax: 0.0,
                           pressure: 0,
                           seaLevel: 0,
                           grndLevel: 0,
                           humidity: 0,
                           tempKf: 0.0),
                       weather: [ForecastResponseBody.List.Weather(
                           id: 0,
                           main: "main",
                           description: "Description",
                           icon: "icon"),
                        
                       ],
                       clouds: ForecastResponseBody.List.Clouds.init(all: 0),
                       wind: ForecastResponseBody.List.Wind.init(
                           speed: 0.0,
                           deg: 0,
                           gust: 0.0),
                       visibility: 0,
                       pop: 0.0,
                       rain: ForecastResponseBody.List.Rain.init(the3H: 0.0),
                       sys: ForecastResponseBody.List.Sys.init(pod: "pod"),
                       dtTxt: "2022-08-30 18:00:00"),
                   ForecastResponseBody.List(
                       dt: 0,
                       main: ForecastResponseBody.List.Main(
                           temp: 0.0,
                           feelsLike: 0.0,
                           tempMin: 0.0,
                           tempMax: 0.0,
                           pressure: 0,
                           seaLevel: 0,
                           grndLevel: 0,
                           humidity: 0,
                           tempKf: 0.0),
                       weather: [ForecastResponseBody.List.Weather(
                           id: 0,
                           main: "main",
                           description: "Description",
                           icon: "icon")],
                       clouds: ForecastResponseBody.List.Clouds.init(all: 0),
                       wind: ForecastResponseBody.List.Wind.init(
                           speed: 0.0,
                           deg: 0,
                           gust: 0.0),
                       visibility: 0,
                       pop: 0.0,
                       rain: ForecastResponseBody.List.Rain.init(the3H: 0.0),
                       sys: ForecastResponseBody.List.Sys.init(pod: "pod"),
                       dtTxt: "2022-08-30 18:00:00")
            ],
            city: ForecastResponseBody.City.init(
                id: 0,
                name: "City name",
                coord: ForecastResponseBody.City.Coord(lat: 0.0, lon: 0.0),
                country: "Country",
                population: 0,
                timezone: 0,
                sunrise: 0,
                sunset: 0))
    )
}
