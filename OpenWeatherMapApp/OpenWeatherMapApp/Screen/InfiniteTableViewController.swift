//
//  InfiniteTableViewController.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 30.07.2025.
//

import UIKit

class InfiniteTableViewController: UIViewController {

    private let tableView = UITableView()
    private var items: [Int] = []
    private var isLoading = false
    private var currentValue = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        loadMoreContent()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadMoreContent() {
        guard !isLoading else { return }
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let newItems = (self.currentValue..<(self.currentValue + 20)).map { $0 }
            self.items.append(contentsOf: newItems)
            self.currentValue += 20
            self.tableView.reloadData()
            self.isLoading = false
        }
    }
}

extension InfiniteTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(items[indexPath.row])"
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .medium)
        cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // scrollView'in dikey eksendeki (Y) mevcut kaydırma konumunu alıyoruz
        let offsetY = scrollView.contentOffset.y
        
        // scrollView içeriğinin toplam yüksekliğini alıyoruz
        let contentHeight = scrollView.contentSize.height
        
        // scrollView'in görünen (ekranda gösterilen) yüksekliğini alıyoruz
        let height = scrollView.frame.size.height

        // Eğer kullanıcı scroll'u içeriğin sonuna kadar kaydırdıysa (veya biraz daha fazlası)
        if offsetY > contentHeight - height {
            // Daha fazla içerik yükleme işlemi tetikleniyor
            loadMoreContent()
        }
    }
}
