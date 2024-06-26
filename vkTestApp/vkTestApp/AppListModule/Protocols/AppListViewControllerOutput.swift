//
//  AppListViewControllerOutput.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import Foundation

protocol AppListViewControllerOutput: AnyObject {
    func setupReady()
    func handleDeepLinkFor(_ url: URL)
}
