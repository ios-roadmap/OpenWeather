//
//  OpenWeatherView.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 27.07.2025.
//

import UIKit

protocol OpenWeatherViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func showWeather(_ viewModel: OpenWeatherViewModel)
    func showError(_ message: String)
}

final class OpenWeatherViewController: UIViewController, OpenWeatherViewProtocol {
    
    var presenter: OpenWeatherPresenterProtocol!
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statusLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    // MARK: - OpenWeatherViewProtocol
    
    func showLoading() {
        statusLabel.text = "Fetching weather..."
    }
    
    func hideLoading() {
        // spinner varsa gizle
    }
    
    func showWeather(_ viewModel: OpenWeatherViewModel) {
        statusLabel.text = viewModel.temperatureText
    }
    
    func showError(_ message: String) {
        statusLabel.text = "Error: \(message)"
    }
}
