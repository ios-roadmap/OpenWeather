//
//  AlertManager.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 30.07.2025.
//

import UIKit

final class AlertManager {
    static let `default` = AlertManager()

    private init() {}

    /// Tek butonlu basit alert
    func showAlert(on viewController: UIViewController,
                   title: String,
                   message: String,
                   buttonTitle: String = "Tamam",
                   completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
        })
        viewController.present(alert, animated: true)
    }

    /// Onay / iptal butonları olan alert
    func showConfirmationAlert(on viewController: UIViewController,
                               title: String,
                               message: String,
                               confirmTitle: String = "Tamam",
                               cancelTitle: String = "İptal",
                               completion: @escaping (_ confirmed: Bool) -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel) { _ in
            completion(false)
        })
        alert.addAction(UIAlertAction(title: confirmTitle, style: .default) { _ in
            completion(true)
        })
        viewController.present(alert, animated: true)
    }
}
