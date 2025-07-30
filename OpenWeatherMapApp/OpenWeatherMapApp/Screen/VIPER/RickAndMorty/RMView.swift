//
//  RMView.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 30.07.2025.
//

import UIKit

final class RMCharacterListViewController: UITableViewController {

    var presenter: RMCharacterListPresenterProtocol!

    // MARK: ‑ Life‑cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        tableView.register(RMCharacterTableViewCell.self,
                           forCellReuseIdentifier: RMCharacterTableViewCell.identifier)
        presenter.viewDidLoad()
    }

    // MARK: ‑ TableView‑DataSource
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: RMCharacterTableViewCell.identifier,
                for: indexPath
        ) as? RMCharacterTableViewCell else { fatalError() }

        let vm = presenter.cellViewModel(at: indexPath.row)
        cell.configure(with: vm)
        return cell
    }

    // MARK: ‑ TableView‑Delegate
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - ViewProtocol conformance
extension RMCharacterListViewController: RMCharacterListViewProtocol {

    func showLoading() {
        LoadingManager.default.show(in: view)
    }

    func hideLoading() {
        LoadingManager.default.hide()
    }

    func reloadData() {
        tableView.reloadData()
    }

    func showError(_ message: String) {
        AlertManager.default.showAlert(
            on: self,
            title: "Error",
            message: message
        )
    }
}
