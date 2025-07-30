//
//  RMPresenter.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 30.07.2025.
//

import Foundation

final class RMCharacterListPresenter: RMCharacterListPresenterProtocol {

    private weak var view: RMCharacterListViewProtocol?
    private let interactor: RMCharacterListInteractorInputProtocol
    private let router: RMCharacterListRouterProtocol

    private var items: [RMCharacter] = []

    init(view: RMCharacterListViewProtocol,
         interactor: RMCharacterListInteractorInputProtocol,
         router: RMCharacterListRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    // MARK: - Presenter → View life‑cycle
    func viewDidLoad() {
        view?.showLoading()
        interactor.fetchCharacters()
    }

    func viewWillAppear() { } // if you need analytics etc.

    // MARK: - Table helpers
    var numberOfItems: Int {
        items.count
    }

    func cellViewModel(at index: Int) -> RMCharacterTableViewCellViewModel {
        RMCharacterTableViewCellViewModel(
            title: items[index].name ?? "-"
        )
    }

    func didSelectRow(at index: Int) {
        router.navigateToDetail(from: view!, with: items[index])
    }
}

// MARK: - Interactor → Presenter
extension RMCharacterListPresenter: RMCharacterListInteractorOutputProtocol {
    func didFetchCharacters(_ characters: [RMCharacter]) {
        items = characters
        view?.hideLoading()
        view?.reloadData()
    }

    func didFailFetchingCharacters(_ error: Error) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
}
