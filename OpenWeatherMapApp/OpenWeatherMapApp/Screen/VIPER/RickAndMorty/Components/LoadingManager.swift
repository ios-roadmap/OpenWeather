//
//  LoadingManager.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 30.07.2025.
//

import UIKit

final class LoadingManager {
    static let `default` = LoadingManager()

    private var activityIndicator: UIActivityIndicatorView?

    private init() {}

    func show(in view: UIView, style: UIActivityIndicatorView.Style = .large, color: UIColor = .gray) {
        if activityIndicator == nil {
            let indicator = UIActivityIndicatorView(style: style)
            indicator.color = color
            indicator.hidesWhenStopped = true
            indicator.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(indicator)

            NSLayoutConstraint.activate([
                indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])

            activityIndicator = indicator
        }

        activityIndicator?.startAnimating()
    }

    func hide() {
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        activityIndicator = nil
    }
}
