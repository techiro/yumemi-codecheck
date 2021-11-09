//
//  SearchRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/11/07.
//

import Foundation
import UIKit

// MARK: View→Presenter Viewが持ってる能力(パラメータ)
protocol SearchRepositoryInput {
    var numberOfRepositories: Int { get }
    func tap(_ sendar: UISearchBar)
    func selectRow(at: IndexPath)
    func repository(index: IndexPath) -> Repository
}

// MARK: Presenter→View
protocol SearchRepositoryPresenterOutput: AnyObject {
    func updateRepositories(_ repositories: [Repository])
    func presentDetail(at: IndexPath)
}

final class SearchRepositoryPresenter: SearchRepositoryInput {

    var numberOfRepositories: Int {
        return repositories.count
    }
    private(set) var repositories: [Repository] = []
    private weak var view: SearchRepositoryPresenterOutput!
    private var model: SearchRepositoryModelInput

    init(view: SearchRepositoryPresenterOutput, model: SearchRepositoryModelInput) {
        self.view = view
        self.model = model
    }

    func tap(_ sendar: UISearchBar) {
        guard let word = sendar.text else { return }
        model.fetchRepository(word: word) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories
                DispatchQueue.main.async {
                    self?.view.updateRepositories(repositories)
                }
            case .failure(let error):
                let alert = AlertViewController()
                alert.setAlert(title: error.localizedDescription, message: error.localizedDescription)
            }
        }
    }
    func repository(index: IndexPath) -> Repository {
        let repository = repositories[index.row]
        return repository
    }

    func selectRow(at: IndexPath) {
        // 実際のロジック
        // brabra

        // Presenter→View
        view.presentDetail(at: at)
    }
}
