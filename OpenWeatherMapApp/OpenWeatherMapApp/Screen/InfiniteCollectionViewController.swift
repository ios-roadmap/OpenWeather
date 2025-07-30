//
//  InfiniteCollectionViewController.swift
//  OpenWeatherMapApp
//
//  Created by Ömer Faruk Öztürk on 30.07.2025.
//

import UIKit

class InfiniteCollectionViewController: UIViewController {

    private var collectionView: UICollectionView!
    private var items: [Int] = []
    private var isLoading = false
    private var currentValue = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        loadMoreContent()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 32, height: 44)
        layout.minimumLineSpacing = 12
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadMoreContent() {
        guard !isLoading else { return }
        isLoading = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let newItems = (self.currentValue..<(self.currentValue + 20)).map { $0 }
            self.items.append(contentsOf: newItems)
            self.currentValue += 20
            self.collectionView.reloadData()
            self.isLoading = false
        }
    }
}

extension InfiniteCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        var label = cell.contentView.viewWithTag(99) as? UILabel

        if label == nil {
            label = UILabel()
            label?.tag = 99
            label?.translatesAutoresizingMaskIntoConstraints = false
            label?.textAlignment = .center
            label?.font = UIFont.monospacedDigitSystemFont(ofSize: 18, weight: .medium)
            label?.backgroundColor = UIColor(white: 0.95, alpha: 1)
            label?.layer.cornerRadius = 8
            label?.clipsToBounds = true
            cell.contentView.addSubview(label!)
            NSLayoutConstraint.activate([
                label!.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
                label!.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
                label!.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
                label!.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
            ])
        }

        label?.text = "\(items[indexPath.item])"
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height

        if offsetY > contentHeight - height {
            loadMoreContent()
        }
    }
}
