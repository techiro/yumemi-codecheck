//
//  SearchRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/11/07.
//

import Foundation
import UIKit

// MARK: View→Presenter Viewが持ってる能力(パラメータ)
protocol SearchInput {
    var numberOfRepositories: Int { get }
    func tap(_ sendar: UISearchBar)
    func selectRow(at index: IndexPath)
    func repository(index: IndexPath) -> Repository
}

// MARK: Presenter→View
protocol SearchPresenterOutput: AnyObject {
    func updateRepositories(_ repositories: [Repository])
    func presentDetail(at index: IndexPath)
    func showAlert(_ alert: UIAlertController)
}

final class SearchPresenter: SearchInput {

    var numberOfRepositories: Int {
        return repositories.count
    }
    private(set) var repositories: [Repository] = []
    private weak var view: SearchPresenterOutput!
    private var model: SearchModelInput

    init(view: SearchPresenterOutput, model: SearchModelInput) {
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
                let errorMessage: String
                switch error {
                case .statusCode(let message):
                    errorMessage = message
                case .parse(let message):
                    errorMessage = message
                }
                let alert = AlertView().setAlert(title: "Github通信エラー", message: errorMessage)
                self?.view.showAlert(alert)
            }
        }
    }
    func repository(index: IndexPath) -> Repository {
        let repository = repositories[index.row]
        return repository
    }

    func selectRow(at index: IndexPath) {
        view.presentDetail(at: index)
    }
}
