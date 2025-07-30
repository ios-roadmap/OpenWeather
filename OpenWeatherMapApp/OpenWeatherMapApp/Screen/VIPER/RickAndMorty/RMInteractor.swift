//
//  RMInteractor.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 30.07.2025.
//

import Foundation

final class RMCharacterListInteractor: RMCharacterListInteractorInputProtocol {

    weak var output: RMCharacterListInteractorOutputProtocol?

    func fetchCharacters() {
        Client.getRickAndMorty { [weak self] response, error in
            guard let self else { return }

            if let error {
                self.output?.didFailFetchingCharacters(error)
                return
            }

            let chars = response?.results ?? []
            self.output?.didFetchCharacters(chars)
        }
    }
}
