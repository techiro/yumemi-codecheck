//
//  ImageAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/28.
//

import Foundation

final class ImageAPI {

    func getImage(from url: String?, completion: @escaping (Result<Data, ImageError>) -> Void) {
        guard let url = url else { return completion(.failure(.urlError(message: "urlがStringではありません"))) }
        guard let imgURL = URL(string: url) else { return completion(.failure(.urlError(message: "urlが正しくありません"))) }

        URLSession.shared.dataTask(with: imgURL) { (data, _, _) in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.dataError(message: "画像が読み込めません")))
            }
        }.resume()
    }

    enum ImageError: Error {
        case urlError(message: String)
        case dataError(message: String)
    }
}

#if DEBUG
class MockImageAPI {
    var isSuccess: Bool

    init(isSuccess: Bool = true) {
        self.isSuccess = isSuccess
    }

    func getImage(from url: String?, completion: @escaping (Result<Data, ImageAPI.ImageError>) -> Void) {

        if isSuccess {
            completion(.success(Data()))
        } else {
            completion(.failure(.urlError(message: "mock URLError")))
        }
    }
}
#endif
