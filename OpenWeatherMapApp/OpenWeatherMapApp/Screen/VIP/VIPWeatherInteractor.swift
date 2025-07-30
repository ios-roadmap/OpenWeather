//
//  VIPWeatherInteractor.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 29.07.2025.
//

import Foundation

protocol VIPWeatherBusinessLogic {
    func fetchWeather(request: VIPWeatherModels.FetchWeather.Request)
}

protocol VIPWeatherDataStore {
    var weather: VIPWeatherModels.Service.OpenWeather? { get set }
}

final class VIPWeatherInteractor: VIPWeatherBusinessLogic, VIPWeatherDataStore {
    
    var presenter: VIPWeatherPresentationLogic?
    var worker: VIPWeatherWorkerProtocol = VIPWeatherWorker()
    var weather: VIPWeatherModels.Service.OpenWeather?
    
    func fetchWeather(request: VIPWeatherModels.FetchWeather.Request) {
        worker.fetchWeather(lat: request.lat, long: request.long) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let weather):
                self.weather = weather
                presenter?.presentWeather(
                    response: .init(weather: weather, error: nil)
                )
            case .failure(let error):
                presenter?.presentWeather(
                    response: .init(weather: nil, error: error)
                )
            }
        }
    }

}
