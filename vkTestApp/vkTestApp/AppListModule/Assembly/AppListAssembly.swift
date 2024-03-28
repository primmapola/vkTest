//
//  AppListAssembly.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import Foundation

final class AppListAssembly {
    
    private let view = AppListViewController()
    private let presenter = AppListPresenter()
    
    func assemble() -> AppListViewController {
        configureDependecies()
        return view
    }
    
    private func configureDependecies() {
        view.presenter = presenter
        presenter.view = view
    }
}
