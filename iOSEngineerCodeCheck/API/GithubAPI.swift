//
//  ItemsRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/28.
//

import Foundation

protocol GitHubAPIProtocol {
    func fetchRepositories(word: String, completion: @escaping (Result<SearchRepositoriesResponse, GitHubAPI.APIError>) -> Void)
}
final class GitHubAPI: GitHubAPIProtocol {

    func fetchRepositories(word: String, completion: @escaping (Result<SearchRepositoriesResponse, GitHubAPI.APIError>) -> Void) {
        guard let url = GitHubAPI.baseURL.queryItemAdded(name: "q", value: word) else {
            completion(.failure(APIError.parse("文字列エラー")))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let response = response as? HTTPURLResponse {
                guard response.statusCode == 200 else {
                    completion(.failure(APIError.statusCode("通信エラー")))
                    return
                }
            }

            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result: SearchRepositoriesResponse = try decoder.decode(SearchRepositoriesResponse.self, from: data)
                completion(.success(result))
            } catch {
                print("エラーが発生しました：\(error)")
            }
        }
        task.resume()
    }

}

extension GitHubAPI {
    static let baseURL: URL = URL(string: "https://api.github.com/search/repositories")!

    enum APIError: Error {
        case statusCode(_ message: String)
        case parse(_ message: String)
    }
}

#if DEBUG
class MockGitHubAPI: GitHubAPIProtocol {
    var isSuccess: Bool
    init(isSuccess: Bool = true) {
        self.isSuccess = isSuccess
    }
    func fetchRepositories(word: String, completion: @escaping (Result<SearchRepositoriesResponse, GitHubAPI.APIError>) -> Void) {
        if isSuccess {
            completion(.success(SearchRepositoriesResponse.mock()))
        } else {
            completion(.failure(GitHubAPI.APIError.statusCode("mock statusError")))
        }
    }

}

#endif
