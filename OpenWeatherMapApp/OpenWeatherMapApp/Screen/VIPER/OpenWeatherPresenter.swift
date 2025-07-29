//
//  OpenWeatherPresenter.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 27.07.2025.
//

import UIKit

// MARK: - ViewModel (UI’ya özel)

struct OpenWeatherViewModel {
    let temperatureText: String
}

// MARK: - Presenter

@MainActor
protocol OpenWeatherPresenterProtocol: AnyObject {
    var view: OpenWeatherViewProtocol? { get set }
    func viewDidLoad()
}

final class OpenWeatherPresenter: OpenWeatherPresenterProtocol {
    
    weak var view: OpenWeatherViewProtocol?
    private let interactor: OpenWeatherInteractorInputProtocol
    private let router: OpenWeatherRouterProtocol
    
    private let lat: Double
    private let long: Double
    
    init(
        interactor: OpenWeatherInteractorInputProtocol,
        router: OpenWeatherRouterProtocol,
        lat: Double,
        long: Double
    ) {
        self.interactor = interactor
        self.router = router
        self.lat = lat
        self.long = long
    }
    
    func viewDidLoad() {
        view?.showLoading()
        interactor.fetchWeather(lat: lat, long: long)
    }
}

extension OpenWeatherPresenter: OpenWeatherInteractorOutputProtocol {
    func weatherFetched(_ weather: OpenWeather) {
        let celsius = weather.main.temp - 273.15
        let vm = OpenWeatherViewModel(temperatureText: String(format: "Temperature: %.1f°C", celsius))
        view?.hideLoading()
        view?.showWeather(vm)
    }
    
    func weatherFetchFailed(_ error: Error) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
}
