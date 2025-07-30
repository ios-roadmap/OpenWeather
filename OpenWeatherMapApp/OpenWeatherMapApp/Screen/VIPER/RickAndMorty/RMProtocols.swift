//
//  RMProtocols.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 30.07.2025.
//

import UIKit

// MARK: - View
protocol RMCharacterListViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func reloadData()
    func showError(_ message: String)
}

// MARK: - Presenter
protocol RMCharacterListPresenterProtocol: AnyObject {
    var numberOfItems: Int { get }
    func viewDidLoad()
    func viewWillAppear()
    func cellViewModel(at index: Int) -> RMCharacterTableViewCellViewModel
    func didSelectRow(at index: Int)
}

// MARK: - Interactor
protocol RMCharacterListInteractorInputProtocol: AnyObject {
    func fetchCharacters()
}
protocol RMCharacterListInteractorOutputProtocol: AnyObject {
    func didFetchCharacters(_ characters: [RMCharacter])
    func didFailFetchingCharacters(_ error: Error)
}

// MARK: - Router
protocol RMCharacterListRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func navigateToDetail(from view: RMCharacterListViewProtocol, with character: RMCharacter)
}
