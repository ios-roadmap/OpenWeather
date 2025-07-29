//
//  VIPWeatherBuilder.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 29.07.2025.
//

import UIKit

enum VIPWeatherBuilder {
    
    /// VIPWeather scene’ini oluşturur ve tam yapılandırılmış `VIPWeatherViewController` döner.
    static func build(lat: Double, long: Double) -> UIViewController {
        // Katmanlar
        let viewController = VIPWeatherViewController()
        let interactor     = VIPWeatherInteractor()
        let presenter      = VIPWeatherPresenter()
        let worker         = VIPWeatherWorker()
        
        // Wiring
        viewController.interactor = interactor
        
        interactor.presenter = presenter
        interactor.worker    = worker
        
        presenter.viewController = viewController
        
        // İlk isteği tetikle
        interactor.fetchWeather(request: .init(lat: lat, long: long)) // veya sayfa yüklendikten sonra.
        
        return viewController
    }
}
