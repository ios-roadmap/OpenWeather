//
//  RetainCycleViewController.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 29.07.2025.
//

import UIKit

/// Strategy protokolü: farklı mimariler için ekran üretir.
@MainActor
protocol WeatherNavigationStrategy {
    func makeWeatherScene(lat: Double, long: Double) -> UIViewController
}

/// VIP (Clean‑Swift) stratejisi
struct VIPERWeatherNavigationStrategy: WeatherNavigationStrategy {
    func makeWeatherScene(lat: Double, long: Double) -> UIViewController {
        OpenWeatherRouter.createModule(lat: lat, long: long)
    }
}

struct VIPWeatherNavigationStrategy: WeatherNavigationStrategy {
    func makeWeatherScene(lat: Double, long: Double) -> UIViewController {
        VIPWeatherBuilder.build(lat: lat, long: long)
    }
}

/// MVVM stratejisi
struct MVVMWeatherNavigationStrategy: WeatherNavigationStrategy {
    func makeWeatherScene(lat: Double, long: Double) -> UIViewController {
        let viewModel = WeatherViewModel(lat: lat, long: long)
        return WeatherViewController(viewModel: viewModel)
    }
}

struct RMNavigationStrategy: WeatherNavigationStrategy {
    func makeWeatherScene(lat: Double, long: Double) -> UIViewController {
        RMCharacterListRouter.createModule()
    }
}

struct StackViewPaginationNavigationStrategy: WeatherNavigationStrategy {
    func makeWeatherScene(lat: Double, long: Double) -> UIViewController {
        InfiniteCounterViewController()
    }
}

struct CollectionViewPaginationNavigationStrategy: WeatherNavigationStrategy {
    func makeWeatherScene(lat: Double, long: Double) -> UIViewController {
        InfiniteCollectionViewController()
    }
}

struct TableViewPaginationNavigationStrategy: WeatherNavigationStrategy {
    func makeWeatherScene(lat: Double, long: Double) -> UIViewController {
        InfiniteTableViewController()
    }
}

final class RetainCycleViewController: UIViewController {
    
    private let buttons: [(title: String, action: Selector)] = [
        ("Open VIPER Weather", #selector(didTapVIPER)),
        ("Open VIP Weather", #selector(didTapVIP)),
        ("Open MVVM Weather", #selector(didTapMVVM)),
        ("Rick And Morty App", #selector(didTapRM)),
        ("Stack View Pagination", #selector(didTapStackViewPagination)),
        ("Collection View Pagination", #selector(didTapCollectionViewPagination)),
        ("Table View Pagination", #selector(didTapTableViewPagination)),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupStackView()
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        buttons.forEach { config in
            let button = UIButton(type: .system)
            button.setTitle(config.title, for: .normal)
            button.addTarget(self, action: config.action, for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc private func didTapVIPER() {
        navigate(with: VIPERWeatherNavigationStrategy())
    }
    
    @objc private func didTapVIP() {
        navigate(with: VIPWeatherNavigationStrategy())
    }
    
    @objc private func didTapMVVM() {
        navigate(with: MVVMWeatherNavigationStrategy())
    }
    
    @objc private func didTapRM() {
        navigate(with: RMNavigationStrategy())
    }
    
    @objc private func didTapStackViewPagination() {
        navigate(with: StackViewPaginationNavigationStrategy())
    }
    
    @objc private func didTapCollectionViewPagination() {
        navigate(with: CollectionViewPaginationNavigationStrategy())
    }

    @objc private func didTapTableViewPagination() {
        navigate(with: TableViewPaginationNavigationStrategy())
    }
    
    private func navigate(with strategy: WeatherNavigationStrategy) {
        let vc = strategy.makeWeatherScene(lat: 41.0082, long: 28.9784)
        navigationController?.pushViewController(vc, animated: true)
    }
}
