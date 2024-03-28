//
//  AppListViewController.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import UIKit

final class AppListViewController: UIViewController {
    
    var presenter: AppListViewControllerOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        presenter?.setupReady()
    }
}

extension AppListViewController: AppListViewControllerInput {
    
}
