//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/28.
//

import Foundation

struct SearchRepositoriesResponse: Decodable {
    let items: [Repository]
}

struct Repository: Decodable {
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
