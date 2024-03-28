//
//  AppListPresenter.swift
//  vkTestApp
//
//  Created by Grigory Don on 28.03.2024.
//

import Foundation
import Combine

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
            .handleEvents(receiveCancel: {
                print("ViewModel: Подписка была отменена")
            })
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("ViewModel: Получение данных завершено")
                case .failure(let error):
                    print("ViewModel: Ошибка при получении данных: \(error)")
                }
            }, receiveValue: { appModel in
                print("ViewModel: Полученные данные: \(appModel)")
            })
            .store(in: &cancellables)
    }
}


// MARK: - AppListViewControllerOutput

extension AppListPresenter: AppListViewControllerOutput {
    func setupReady() {
        loadData()
    }
}
