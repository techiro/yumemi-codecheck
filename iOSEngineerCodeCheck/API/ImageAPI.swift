//
//  ImageAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/28.
//

import Foundation

final class ImageAPI {

    func getImage(from url: String?, completion: @escaping (Result<Data, ImageError>) -> Void) {

        if let imgURL = url {
            // swiftlint:disable force_unwrapping
            // TODO: fix: force unwrapping
            URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, _, _) in
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(.dataError(message: "画像が読み込めません")))
                }
            }.resume()
        } else {
            completion(.failure(.urlError(message: "urlが正しくありません")))
        }
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
