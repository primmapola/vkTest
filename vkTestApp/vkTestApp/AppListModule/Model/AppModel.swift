//
//  AppModel.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import Foundation

struct AppModel: Decodable {
    let body: Body
    let status: Int
}

struct Body: Decodable {
    let services: [Service]
}

struct Service: Decodable {
    let name: String
    let description: String
    let link: String
    let icon_url: String
}

