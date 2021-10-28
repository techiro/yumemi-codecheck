//
//  ItemsRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/28.
//

import Foundation

final class GitHubAPI {

    static func fetchRepositories(word: String, completion: @escaping (Result<SearchRepositoriesResponse, Error>) -> Void) {
        let url = GitHubAPI.baseURL.queryItemAdded(name: "q", value: word)!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            if let response = response as? HTTPURLResponse {
                guard response.statusCode == 200 else {
                    completion(.failure(ResponseError(statusCode: response.statusCode)))
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
}

struct ResponseError: Error {
    var statusCode: Int
}
