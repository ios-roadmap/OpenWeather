//
//  VIPWeatherWorker.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 29.07.2025.
//

import Foundation

protocol VIPWeatherWorkerProtocol {
    func fetchWeather(
        lat: Double,
        long: Double,
        completion: @escaping (Result<VIPWeatherModels.Service.OpenWeather, Error>) -> Void
    )
}

final class VIPWeatherWorker: VIPWeatherWorkerProtocol {
    
    func fetchWeather(
        lat: Double,
        long: Double,
        completion: @escaping (Result<VIPWeatherModels.Service.OpenWeather, Error>) -> Void
    ) {
        Client.getWeatherByLatLong(lat: lat, long: long) { weather, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            if let weather {
                completion(.success(VIPWeatherModels.Service.OpenWeather(main: .init(temp: weather.main.temp))))
            }
        }
    }

}
