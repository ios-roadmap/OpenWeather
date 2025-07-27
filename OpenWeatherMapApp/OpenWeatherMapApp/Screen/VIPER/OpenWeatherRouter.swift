//
//  WeatherForecastRouter.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 27.07.2025.
//

import UIKit

protocol OpenWeatherRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToDetail(from view: OpenWeatherViewProtocol, with weather: OpenWeather)
}

final class OpenWeatherRouter: OpenWeatherRouterProtocol {
    
    static func createModule() -> UIViewController {
        let view = OpenWeatherViewController()
        let interactor = OpenWeatherInteractor()
        let router = OpenWeatherRouter()
        let presenter = OpenWeatherPresenter(interactor: interactor, router: router)
        
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
