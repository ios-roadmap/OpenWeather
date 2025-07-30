//
//  RMRouter.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 30.07.2025.
//

import UIKit

final class RMCharacterListRouter: RMCharacterListRouterProtocol {

    // Assembles and returns the module’s root VC
    static func createModule() -> UIViewController {
        let view   = RMCharacterListViewController()
        let interactor = RMCharacterListInteractor()
        let router = RMCharacterListRouter()
        let presenter = RMCharacterListPresenter(view: view,
                                                 interactor: interactor,
                                                 router: router)
        view.presenter = presenter
        interactor.output = presenter
        return view
    }

    // Navigation stub
    func navigateToDetail(from view: RMCharacterListViewProtocol,
                          with character: RMCharacter) {
        // push or present another module – left empty for brevity
    }
}
