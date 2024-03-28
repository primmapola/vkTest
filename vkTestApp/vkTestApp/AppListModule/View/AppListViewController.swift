//
//  AppListViewController.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import UIKit

final class AppListViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: AppListViewControllerOutput?
    
    private lazy var serviceCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 110)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(ServiceCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.accessibilityIdentifier = "ServiceCollectionView"
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    private var displayData: [ServiceViewModel] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.setupReady()
        setupNavigationBar()
        setupUI()
    }
}

// MARK: - User interface

private extension AppListViewController {
    func setupUI() {
        view.addSubview(serviceCollectionView)
        
        self.view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            serviceCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            serviceCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            serviceCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            serviceCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Сервисы"
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension AppListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        displayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ServiceCell else {
            return UICollectionViewCell()
        }
        
        let viewModel = displayData[indexPath.row]
        cell.delegate = presenter as? ServiceCellDelegate
        cell.configureWithDisplayData(viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.secondarySystemBackground
    }

    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.systemBackground
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedViewModel = displayData[indexPath.row]
        presenter?.handleDeepLinkFor(selectedViewModel.link)
    }
}

// MARK: - AppListViewControllerInput

extension AppListViewController: AppListViewControllerInput {
    func displayData(_ data: [ServiceViewModel]) {
        self.displayData = data
        serviceCollectionView.reloadData()
    }
}
