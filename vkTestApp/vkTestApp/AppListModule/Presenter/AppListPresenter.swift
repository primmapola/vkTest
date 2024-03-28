//
//  AppListPresenter.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import Foundation
import Combine
import UIKit

final class AppListPresenter {
    
    weak var view: AppListViewControllerInput?
    private var cancellables: Set<AnyCancellable> = []
    
    deinit {
        print("presenter deinited")
    }
}

private extension AppListPresenter {
    func loadData() {
        DataService.shared.fetchData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    print("Presenter: Получение данных завершено")
                case .failure(let error):
                    print("Presenter: Ошибка при получении данных: \(error)")
                }
            }, receiveValue: { [weak self] appModel in
                print("Presenter: Полученные данные: \(appModel)")
                let appViewModel = AppViewModel(from: appModel)
                self?.view?.displayData(appViewModel.services)
            })
            .store(in: &cancellables)
    }
    
    func loadImageForViewModel(_ viewModel: ServiceViewModel, completion: @escaping (UIImage?) -> Void) {
        if let imageUrl = viewModel.iconURL {
            ImageLoadingService.shared.loadImage(from: imageUrl)
                .sink(receiveValue: { image in
                    completion(image ?? UIImage(systemName: "photo"))
                })
                .store(in: &cancellables)
        } else {
            completion(UIImage(systemName: "photo"))
        }
    }
}

// MARK: - AppListViewControllerOutput

extension AppListPresenter: AppListViewControllerOutput, ServiceCellDelegate {
    func handleDeepLinkFor(_ url: URL) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    func setupReady() {
        loadData()
    }
    
    func loadImageForCell(_ cell: ServiceCell, url: URL) {
        loadImageForViewModel(url) { image in
            DispatchQueue.main.async {
                cell.serviceImage.image = image
            }
        }
    }
    
    private func loadImageForViewModel(_ url: URL, completion: @escaping (UIImage?) -> Void) {
        ImageLoadingService.shared.loadImage(from: url)
            .sink(receiveValue: { image in
                completion(image ?? UIImage(systemName: "photo"))
            })
            .store(in: &cancellables)
    }
}
