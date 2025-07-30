//
//  InfiniteCounterViewController.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 30.07.2025.
//

import UIKit

class InfiniteCounterViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private var isLoading = false
    private var currentValue = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
        setupStackView()
        scrollView.delegate = self
        loadMoreContent()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }

    private func loadMoreContent() {
        guard !isLoading else { return }
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            for _ in 0..<20 {
                let label = UILabel()
                label.text = "\(self.currentValue)"
                label.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .medium)
                label.textAlignment = .center
                label.backgroundColor = UIColor(white: 0.95, alpha: 1)
                label.layer.cornerRadius = 8
                label.clipsToBounds = true
                label.heightAnchor.constraint(equalToConstant: 44).isActive = true

                self.stackView.addArrangedSubview(label)
                self.currentValue += 1
            }

            self.isLoading = false
        }
    }
}

extension InfiniteCounterViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            loadMoreContent()
        }
    }
}
