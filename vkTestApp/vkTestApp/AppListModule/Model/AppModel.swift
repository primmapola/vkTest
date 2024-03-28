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

extension AppModel: Equatable {
    static func == (lhs: AppModel, rhs: AppModel) -> Bool {
        return lhs.status == rhs.status && lhs.body == rhs.body
    }
}

extension Body: Equatable {
    static func == (lhs: Body, rhs: Body) -> Bool {
        return lhs.services == rhs.services
    }
}

extension Service: Equatable {
    static func == (lhs: Service, rhs: Service) -> Bool {
        return lhs.name == rhs.name &&
               lhs.description == rhs.description &&
               lhs.link == rhs.link &&
               lhs.icon_url == rhs.icon_url
    }
}

