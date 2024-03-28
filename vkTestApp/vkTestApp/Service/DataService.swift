//
//  DataService.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import Foundation
import Alamofire
import Combine

class DataService {
    static let shared = DataService()

    private init() {}

    func fetchData() -> AnyPublisher<AppModel, Error> {
        let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
        return Future<AppModel, Error> { promise in
            AF.request(urlString)
                .validate()
                .responseDecodable(of: AppModel.self) { response in
                    switch response.result {
                    case .success(let data):
                        print("DataService: Success with data: ")
                        promise(.success(data))
                    case .failure(let error):
                        print("DataService: Error occurred: \(error)")
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }
}


