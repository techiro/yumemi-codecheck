//
//  DetailRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/11/09.
//

import Foundation
import UIKit

protocol DetailPresenterInput {
    var repository: Repository { get }
    var fullName: String { get }
    var language: String { get }
    var wachersCount: String { get }
    var forksCount: String { get }
    var openIssuesCounts: String { get }
    var starsCount: String { get }

    func fetchImage()
}

protocol DetailPresenterOutput: AnyObject {
    func setImage(image: UIImage?)
    func showAlert(_ alert: UIAlertController)
}

protocol DetailModelInput: AnyObject {
    func fetchImage(from url: String?, completion: @escaping (Result<Data, ImageAPI.ImageError>) -> Void)
}
final class DetailPresenter: DetailPresenterInput {

    private weak var view: DetailPresenterOutput!
    private var model: DetailModelInput!

    let repository: Repository

    var fullName: String {
        repository.fullName
    }
    var language: String {
        repository.language ?? ""
    }
    var wachersCount: String {
        "\(repository.wachersCount ?? 0) watchers"
    }
    var forksCount: String {
        "\(repository.forksCount ?? 0) forks"
    }
    var openIssuesCounts: String {
        "\(repository.openIssuesCount ?? 0) open issues"
    }
    var starsCount: String {
        "\(repository.stargazersCount ?? 0) stars"
    }

    func fetchImage() {
        model.fetchImage(from: repository.owner?.avatarUrl) { result in
            switch result {
            case .success(let data):
                self.view.setImage(image: UIImage(data: data))
            case .failure(let error):
                let message: String
                switch error {
                case .urlError(let _message):
                    message = _message

                case .dataError(let _message):
                    message = _message
                }
                let alert = AlertView().setAlert(title: "イメージエラー", message: message)
                self.view.showAlert(alert)
            }
        }
    }

    init(view: DetailPresenterOutput, repository: Repository, model: DetailModelInput) {
        self.view = view
        self.repository = repository
        self.model = model
    }

}
