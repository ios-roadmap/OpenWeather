//
//  OpenWeatherInteractor.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 27.07.2025.
//

import UIKit

protocol OpenWeatherInteractorInputProtocol: AnyObject {
    func fetchWeather(lat: Double, long: Double)
}

protocol OpenWeatherInteractorOutputProtocol: AnyObject {
    func weatherFetched(_ weather: OpenWeather)
    func weatherFetchFailed(_ error: Error)
}

final class OpenWeatherInteractor: OpenWeatherInteractorInputProtocol {
    
    weak var presenter: OpenWeatherInteractorOutputProtocol?
    
    func fetchWeather(lat: Double, long: Double) {
        Client.getWeatherByLatLong(lat: lat, long: long) { [weak self] weather, error in
            if let err = error {
                self?.presenter?.weatherFetchFailed(err)
                return
            }
            if let w = weather {
                self?.presenter?.weatherFetched(w)
            }
        }
    }
}
