//
//  SearchRepositoryModel.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/11/07.
//

import Foundation
protocol SearchModelInput {
    func fetchRepository(word: String, completion: @escaping (Result<[Repository], GitHubAPI.APIError>) -> Void)
}

final class SearchModel: SearchModelInput {

    func fetchRepository(word: String, completion: @escaping (Result<[Repository], GitHubAPI.APIError>) -> Void) {
        let api = GitHubAPI()
        api.fetchRepositories(word: word) { result in
            switch result {
            case .success(let response):
                completion(.success(response.items))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
