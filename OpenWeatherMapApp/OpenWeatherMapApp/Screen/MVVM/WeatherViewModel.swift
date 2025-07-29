//
//  WeatherViewModel.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 27.07.2025.
//

import UIKit

@MainActor
protocol HomePageViewModelDelegate: AnyObject {
    func fetchLoaded()
    func fetchFailed(error: Error)
    func preFetch()
}

@MainActor
final class WeatherViewModel: ObservableObject {
    
    weak var delegate: HomePageViewModelDelegate? // weak: Retain Cycle
    @Published private(set) var weather: OpenWeather?
    
    let lat: Double
    let long: Double
    
    init(
        lat: Double,
        long: Double
    ) {
        self.lat = lat
        self.long = long
    }
    
    func fetchWeather() {
        delegate?.preFetch()
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            Client.getWeatherByLatLong(lat: lat, long: long) { weather, error in
                if let error {
                    self.delegate?.fetchFailed(error: error)
                }
                self.weather = weather
                self.delegate?.fetchLoaded()
            }
        }
    }
}
