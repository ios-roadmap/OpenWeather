//
//  WeatherForecastRouter.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 27.07.2025.
//

import UIKit

@MainActor
protocol OpenWeatherRouterProtocol: AnyObject {
    static func createModule(lat: Double, long: Double) -> UIViewController
    func navigateToDetail(from view: OpenWeatherViewProtocol, with weather: OpenWeather)
}

final class OpenWeatherRouter: OpenWeatherRouterProtocol {
    
    static func createModule(lat: Double, long: Double) -> UIViewController {
        let view = OpenWeatherViewController()
        let interactor = OpenWeatherInteractor()
        let router = OpenWeatherRouter()
        let presenter = OpenWeatherPresenter(interactor: interactor, router: router, lat: lat, long: long)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
    
    func navigateToDetail(from view: OpenWeatherViewProtocol, with weather: OpenWeather) {
        // Örneğin:
        // let detailVC = OpenWeatherDetailRouter.createModule(with: weather)
        // (view as? UIViewController)?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
