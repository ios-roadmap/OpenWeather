//
//  WeatherViewController.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 27.07.2025.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    private let viewModel: WeatherViewModel = .init()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading..."
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.fetchWeather(lat: 41.0082, long: 28.9784)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func updateUI(with weather: OpenWeather) {
        statusLabel.text = "Temperature: \(weather.main.temp - 273)°C)"
    }
}

// MARK: - HomePageViewModelDelegate

extension WeatherViewController: HomePageViewModelDelegate {
    
    func preFetch() {
        statusLabel.text = "Fetching weather..."
    }
    
    func fetchLoaded() {
        guard let weather = viewModel.weather else {
            statusLabel.text = "No data available"
            return
        }
        updateUI(with: weather)
    }
    
    func fetchFailed(error: Error) {
        statusLabel.text = "Error: \(error.localizedDescription)"
    }
}
