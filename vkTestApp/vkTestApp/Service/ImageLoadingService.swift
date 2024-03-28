//
//  ImageLoadingService.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import Combine
import UIKit

class ImageLoadingService {
    static let shared = ImageLoadingService()

    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map { response -> UIImage? in
                return UIImage(data: response.data)
            }
            .replaceError(with: nil) // В случае ошибки возвращаем nil
            .receive(on: DispatchQueue.main) // Убедимся, что мы на главном потоке
            .eraseToAnyPublisher()
    }
}

