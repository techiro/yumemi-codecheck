//
//  DetailRepositoryPresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/11/09.
//

import Foundation
import UIKit

protocol DetailRepositoryPresenterInput {
    var repository: Repository { get }
    var fullName: String { get }
    var language: String { get }
    var wachersCount: String { get }
    var forksCount: String { get }
    var openIssuesCounts: String { get }
    var starsCount: String { get }
}

protocol DetailRepositoryPresenterOutput: AnyObject {

}

final class DetailRepositoryPresenter: DetailRepositoryPresenterInput {
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

    private weak var view: DetailRepositoryPresenterOutput!
    let repository: Repository

    init(view: DetailRepositoryPresenterOutput, repository: Repository) {
        self.view = view
        self.repository = repository
    }

}
