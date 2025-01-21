//
//  ForecastCardView.swift
//  WeatherApp
//
//  Created by Manendra on 21/01/25.
//

import SwiftUI

struct ForecastCardView: View {
    
    var date_text : String
    var temp : Double
    var feelsLike  : Double
    var weather : String
    var desc : String
    var wind : Double
    var humidity : Int
    var pressure : Int
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.blue).opacity(0.5))
            VStack{
                VStack{
                    
                    Text("\(self.formattedDateTime(from: date_text))")
                        .font(.title2)
                    Text("\(String(format:"%.2f",temp-273.15)) °C")
                        .font(.title2)
                        .bold()
                    Text("Feels like: \(String(format:"%.2f",feelsLike-273.15)) °C")
                        .bold()
                    if let weathericon = IconMapper.iconMapper[weather] {
                        Image(systemName: weathericon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .padding(30)
                    }
                    else {
                        Image(systemName: "sun.and.horizon.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                            .padding(30)
                    }
                    
                    Text(weather)
                        .font(.title3)
                        .bold()
                    Text(desc)
                }.padding()
                HStack{
                    VStack{
                        Image(systemName: "wind")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45)
                        Text("\(wind)" + " m/s")
                    }
                    Spacer(minLength: 10)
                    VStack{
                        Image(systemName: "humidity")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45)
                        Text("\(humidity)" + " %")
                    }
                    Spacer(minLength: 10)
                    VStack{
                        Image(systemName: "rectangle.compress.vertical")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45)
                        Text("\(pressure)" + " hpa")
                    }
                }.padding(.horizontal,50)
            }.padding(10)
        }
        .padding()
        .background(Color(.systemGray6))
        
        
    }
    func formattedDateTime(from dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    if let date = formatter.date(from: dateString) {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d, yyyy   h:mm a"
                return formatter.string(from: date)
            } else {
                return "Invalid Date"
            }
    }
}

#Preview {
    ForecastCardView(
        date_text: "2025-01-21 18:00:00",
        temp: 273.15,
        feelsLike: 273.15,
        weather: "Clear",
        desc: "clear sky",
        wind: 0,
        humidity: 0,
        pressure: 0)
}
