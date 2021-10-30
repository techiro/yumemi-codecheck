//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/28.
//

import Foundation

struct SearchRepositoriesResponse: Decodable, Equatable {
    let items: [Repository]

    static func == (lhs: SearchRepositoriesResponse, rhs: SearchRepositoriesResponse) -> Bool {
        lhs.items == rhs.items
    }

}

struct Repository: Decodable, Equatable {
    static func == (lhs: Repository, rhs: Repository) -> Bool {
        lhs.id == rhs.id
    }

    let id: Int
    let fullName: String
    let language: String?
    let stargazersCount: Int?
    let wachersCount: Int?
    let forksCount: Int?
    let openIssuesCount: Int?
    let owner: Owner?
    let htmlUrl: String?
}

struct Owner: Decodable {
    let avatarUrl: String?
}

extension Repository {
    static func mock() -> Repository {
        return Repository(
            id: 0,
            fullName: "name",
            language: "Swift",
            stargazersCount: nil,
            wachersCount: nil,
            forksCount: nil,
            openIssuesCount: nil,
            owner: nil,
            htmlUrl: nil
        )
    }
}

extension SearchRepositoriesResponse {
    static func mock() -> SearchRepositoriesResponse {
        return SearchRepositoriesResponse(items: [
            Repository.mock()
        ])
    }
}
