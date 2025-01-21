//
//  MainScreenView.swift
//  WeatherApp
//
//  Created by Manendra on 21/01/25.
//

import SwiftUI

struct MainScreenView: View {
    
    @Binding var weather : WeatherResponseBody?
    @Binding var forecast: ForecastResponseBody?
    @ObservedObject var mainViewModel : MainViewModel
    
    var body: some View {
        if mainViewModel.forecast {
            if let forecast = forecast
            {
                ForecastView(
                    mainViewModel: mainViewModel,
                    forecast: forecast
                )
            }
        }
        else {
            WeatherView(weather: weather!, mainViewModel: mainViewModel)
        }
    }
}

#Preview {
    MainScreenView(
        weather:
                .constant(
                    WeatherResponseBody(
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
                    )),
        forecast: .constant(
            ForecastResponseBody(
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
                    dtTxt: "Date time")],
                city: ForecastResponseBody.City.init(
                    id: 0,
                    name: "City name",
                    coord: ForecastResponseBody.City.Coord(lat: 0.0, lon: 0.0),
                    country: "Country",
                    population: 0,
                    timezone: 0,
                    sunrise: 0,
                    sunset: 0))
        ),
        mainViewModel: MainViewModel()
    )
}
