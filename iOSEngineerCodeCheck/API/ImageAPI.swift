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

struct ImageError: Error {}
