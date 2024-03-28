//
//  AppListViewController.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import UIKit

final class AppListViewController: UIViewController {
    
    var presenter: AppListViewControllerOutput?
    
    private lazy var serviceCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 110)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(ServiceCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private var displayData: [ServiceViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        presenter?.setupReady()
        setupUI()
    }
}

private extension AppListViewController {
    func setupUI() {
        view.addSubview(serviceCollectionView)
        
        NSLayoutConstraint.activate([
            serviceCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            serviceCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            serviceCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            serviceCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

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
           cell?.backgroundColor = UIColor.systemGray4
       }

       func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
           let cell = collectionView.cellForItem(at: indexPath)
           cell?.backgroundColor = UIColor.white
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedViewModel = displayData[indexPath.row]
        presenter?.handleDeepLinkFor(selectedViewModel.link)
    }
}

extension AppListViewController: AppListViewControllerInput {
    func displayData(_ data: [ServiceViewModel]) {
        self.displayData = data
        serviceCollectionView.reloadData()
    }
}
