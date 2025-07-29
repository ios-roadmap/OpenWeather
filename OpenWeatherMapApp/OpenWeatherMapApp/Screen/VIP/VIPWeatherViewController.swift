//
//  VIPWeatherViewController.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 29.07.2025.
//

import UIKit

protocol VIPWeatherDisplayLogic: AnyObject {
    func displayWeather(viewModel: VIPWeatherModels.FetchWeather.ViewModel)
}

final class VIPWeatherViewController: UIViewController, VIPWeatherDisplayLogic {
    
    // DI via Builder
    var interactor: VIPWeatherBusinessLogic?
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - VIPWeatherDisplayLogic
    func displayWeather(viewModel: VIPWeatherModels.FetchWeather.ViewModel) {
        DispatchQueue.main.async {
            self.statusLabel.text      = viewModel.temperatureText
            self.statusLabel.textColor = viewModel.isError ? .red : .black
        }
    }
}
