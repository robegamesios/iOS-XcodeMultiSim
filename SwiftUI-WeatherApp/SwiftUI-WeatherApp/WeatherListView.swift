//
//  WeatherListView.swift
//  SwiftUI-WeatherApp
//
//  Created by rob enriquez on 6/20/24.
//

import SwiftUI

struct WeatherListView: View {
    
    @State private var cities: [City] = [
        City(name: "Vallejo", state: "CA"),
        City(name: "San Francisco", state: "CA"),
        City(name: "San Jose", state: "CA"),
        City(name: "Fairfield", state: "CA"),
        City(name: "Bellevue", state: "WA"),
        City(name: "Seattle", state: "WA"),
        City(name: "New York", state: "New York"),
    ]
    
    var filteredCities: [City] {
        guard !searchTerm.isEmpty else {
            return cities
        }
        return cities.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    @State private var searchTerm = ""
    
    var body: some View {
        NavigationStack {
            List(filteredCities, id: \.id) { city in
                Label(city.name, systemImage: "airplane.circle.fill")
            }
            .navigationTitle("Cities")
            .searchable(text: $searchTerm, prompt: "Type your city")
        }
    }
}

#Preview {
    WeatherListView()
}

struct City: Identifiable {
    
    var id = UUID().uuidString
    var name: String
    var state: String
    
}
