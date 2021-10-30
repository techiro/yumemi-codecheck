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
            URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, _, _) in
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(.DataError(message: "画像が読み込めません")))
                }
            }.resume()
        } else {
            completion(.failure(.URLError(message: "urlが正しくありません")))
        }
    }

    enum ImageError: Error {
        case URLError(message: String)
        case DataError(message: String)
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
            completion(.failure(.URLError(message: "mock URLError")))
        }
    }
}

extension MockImageAPI {
    static let failedURL = "https://avatars.githubusercontent.com/u/..."
    static let successURL = "https://avatars.githubusercontent.com/u/8255800?v=4"
}

#endif
