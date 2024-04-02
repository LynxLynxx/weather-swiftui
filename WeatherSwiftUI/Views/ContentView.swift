//
//  ContentView.swift
//  WeatherSwiftUI
//
//  Created by Ryszard Schossler on 02/04/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locaitonManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    var body: some View {
        VStack {
            
            if let location = locaitonManager.location {
                if let weather = weather {
                   WeatherView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather")
                            }
                        }
                }
            } else {
                if locaitonManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView().environmentObject(locaitonManager)
                }
            }
            
        }.background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354)).preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}
