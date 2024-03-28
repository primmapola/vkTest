//
//  AppListViewControllerInput.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import Foundation

protocol AppListViewControllerInput: AnyObject {
    func displayData(_ data: [ServiceViewModel])
}
