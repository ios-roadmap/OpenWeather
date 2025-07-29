//
//  VIPWeatherModels.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 29.07.2025.
//

import Foundation

enum VIPWeatherModels {
    
    // MARK: - Service (API) Models
    enum Service {
        struct OpenWeather: Codable {
            let main: Main
            struct Main: Codable {
                let temp: Double
            }
        }
    }
    
    // MARK: - Use Case: FetchWeather
    enum FetchWeather {
        struct Request {
            let lat: Double
            let long: Double
        }
        
        struct Response {
            let weather: Service.OpenWeather?
            let error: Error?
        }
        
        struct ViewModel {
            let temperatureText: String
            let isError: Bool
        }
    }
}
