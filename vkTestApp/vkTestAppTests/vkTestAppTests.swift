//
//  vkTestAppTests.swift
//  vkTestAppTests
//
//  Created by Grigory Don on 28.03.2024.
//

import XCTest
@testable import vkTestApp
import Combine

class DataServiceTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []

    func testFetchDataSuccess() {
       
        let expectedData = AppModel(
            body: Body(
                services: [
                    Service(
                        name: "Service 1",
                        description: "Description 1",
                        link: "https://link1.com",
                        icon_url: "https://icon1.com"
                    ),
                    Service(
                        name: "Service 2",
                        description: "Description 2",
                        link: "https://link2.com",
                        icon_url: "https://icon2.com"
                    )
                ]
            ),
            status: 200
        )

        DataService.shared.fetchData().sink(receiveCompletion: { _ in }, receiveValue: { data in
            XCTAssertEqual(data, expectedData)
        }).store(in: &cancellables)
    }

    func testFetchDataFailure() {
        DataService.shared.fetchData().sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                XCTAssertNotNil(error)
            case .finished:
                XCTFail("Expected failure, got success")
            }
        }, receiveValue: { _ in
            XCTFail("Expected failure, got success")
        }).store(in: &cancellables)
    }
}
