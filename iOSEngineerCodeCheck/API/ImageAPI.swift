//
//  ImageAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/28.
//

import Foundation

final class ImageAPI {

    static func getImage(from url: String?, completion: @escaping (Result<Data, Error>) -> Void) {

        if let imgURL = url {
            URLSession.shared.dataTask(with: URL(string: imgURL)!) { (data, res, err) in
                if let data = data {
                    completion(.success(data))
                } else {
                    completion(.failure(ImageError()))
                }
            }.resume()
        }
    }
}

struct ImageError: Error {}
