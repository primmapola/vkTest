//
//  vkTestAppUITests.swift
//  vkTestAppUITests
//
//  Created by Grigory Don on 28.03.2024.
//

import XCTest

class AppListViewControllerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testCollectionViewCellTapChangesColor() {
        
        let collectionView = app.collectionViews["ServiceCollectionView"]
        XCTAssertTrue(collectionView.exists, "Коллекция сервисов должна быть доступна")
    }
    
    func testNavigationBarTitle() {
        let navigationBar = app.navigationBars["Сервисы"]
        XCTAssertTrue(navigationBar.exists, "Навигационный бар с заголовком 'Сервисы' должен существовать")
    }
    
}

