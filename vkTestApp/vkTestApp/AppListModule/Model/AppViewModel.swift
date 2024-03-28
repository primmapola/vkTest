//
//  AppViewModel.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import Foundation

struct ServiceViewModel {
    let name: String
    let description: String
    let link: URL
    let iconURL: URL?
}

struct AppViewModel {
    var services: [ServiceViewModel] = []

    init(from model: AppModel) {
        self.services = model.body.services.map { service in
            ServiceViewModel(
                name: service.name,
                description: service.description,
                link: URL(string: service.link)!,
                iconURL: URL(string: service.icon_url)!
            )
        }
    }
}

