//
//  WeatherViewModel.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 27.07.2025.
//

import UIKit

protocol HomePageViewModelDelegate: AnyObject {
    func fetchLoaded()
    func fetchFailed(error: Error)
    func preFetch()
}

@MainActor
final class WeatherViewModel: ObservableObject {
    
    weak var delegate: HomePageViewModelDelegate?
    
    @Published private(set) var weather: OpenWeather?
    
    func fetchWeather(lat: Double, long: Double) {
        delegate?.preFetch()
        DispatchQueue.main.async {
            Client.getWeatherByLatLong(lat: lat, long: long) { [weak self] weather, error in
                guard let self = self else { return }
                if let error {
                    self.delegate?.fetchFailed(error: error)
                }
                self.weather = weather
                self.delegate?.fetchLoaded()
            }
        }
    }
}
