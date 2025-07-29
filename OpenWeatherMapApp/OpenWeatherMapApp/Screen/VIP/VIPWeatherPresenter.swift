//
//  VIPWeatherPresenter.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 29.07.2025.
//

import Foundation

protocol VIPWeatherPresentationLogic {
    func presentWeather(response: VIPWeatherModels.FetchWeather.Response)
}

final class VIPWeatherPresenter: VIPWeatherPresentationLogic {
    
    weak var viewController: VIPWeatherDisplayLogic?
    
    func presentWeather(response: VIPWeatherModels.FetchWeather.Response) {
        if let error = response.error {
            viewController?.displayWeather(
                viewModel: .init(
                    temperatureText: "Error: \(error.localizedDescription)",
                    isError: true
                )
            )
            return
        }
        
        guard let weather = response.weather else {
            viewController?.displayWeather(
                viewModel: .init(
                    temperatureText: "No data available",
                    isError: true
                )
            )
            return
        }
        
        let celsius = weather.main.temp - 273.15
        viewController?.displayWeather(
            viewModel: .init(
                temperatureText: "Temperature: \(Int(celsius))°C",
                isError: false
            )
        )
    }
}
