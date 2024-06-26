//
//  ServiceCellDelegate.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import Foundation

protocol ServiceCellDelegate: AnyObject {
    func loadImageForCell(_ cell: ServiceCell, url: URL)
}

