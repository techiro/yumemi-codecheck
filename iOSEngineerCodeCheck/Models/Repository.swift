//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/28.
//

import Foundation

struct Repository: Decodable, Equatable {

    let id: Int
    let fullName: String
    let language: String?
    let stargazersCount: Int?
    let wachersCount: Int?
    let forksCount: Int?
    let openIssuesCount: Int?
    let owner: Owner?
    let htmlUrl: String?

    static func == (lhs: Repository, rhs: Repository) -> Bool {
        lhs.id == rhs.id
    }
}

#if DEBUG
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
#endif
