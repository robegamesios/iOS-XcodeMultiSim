//
//  WeatherView.swift
//  SwiftUI-WeatherApp
//
//  Created by rob enriquez on 6/19/24.
//

import SwiftUI

struct WeatherView: View {
    
    @State private var viewModel = ViewModel()
    @State private var cityTextField = ""
    
    var body: some View {
        TabView {
            ZStack {
                BackgroundView(isNight: viewModel.isNight)
                
                VStack {
                    CityTextView(cityName: viewModel.weatherResponse?.name ?? "No City")
                    MainWeatherStatusView(imageName: viewModel.isNight ? "moon.stars.fill" : "cloud.sun.fill", temperature: Int(viewModel.weatherResponse?.main?.temp ?? 0))
                    
                    HStack(spacing: 20) {
                        WeatherDayView(dayOfWeek: "TUE",
                                       imageName: "cloud.sun.fill",
                                       temperature: 76)
                        
                        WeatherDayView(dayOfWeek: "WED",
                                       imageName: "sun.max.fill",
                                       temperature: 76)
                        
                        WeatherDayView(dayOfWeek: "THU",
                                       imageName: "wind.snow",
                                       temperature: 76)
                        
                        WeatherDayView(dayOfWeek: "FRI",
                                       imageName: "sunset.fill",
                                       temperature: 76)
                        
                        WeatherDayView(dayOfWeek: "SAT",
                                       imageName: "snow",
                                       temperature: 76)
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.updateIsNight()
                        
                    } label: {
                        WeatherButton(title: "Change Day time",
                                      textColor: .blue,
                                      backgroundColor: .white)
                    }
                    
                    TextField("Type your city", text: $cityTextField)
                        .frame(height: 44)
                        .background()
                        .cornerRadius(10)
                        .padding()
                        .onChange(of: cityTextField, initial: false, { (_, newValue) in
                            Task {
                                await viewModel.getWeather(city: newValue)
                            }
                        })
                    Spacer()
                }
            }
            .tabItem {
                Label("Today", systemImage: "rainbow")
            }
            
            WeatherListView()
                .tabItem {
                    Label("5-Day", systemImage: "thermometer.medium.slash")
                }
        }
        .onAppear {
            Task {
                await viewModel.getWeather(city: "Vallejo")
            }
        }
    }
}

#Preview {
    WeatherView()
}

struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    
    var isNight: Bool
    
    var body: some View {
        LinearGradient(colors: [isNight ? .black : .blue, isNight ? .gray : .yellow], startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium))
        .foregroundColor(.white)
        .padding()
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing:10) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}
