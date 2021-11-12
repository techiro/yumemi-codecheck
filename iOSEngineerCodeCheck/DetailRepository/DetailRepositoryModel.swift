//
//  DetailRepositoryModel.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/11/12.
//

import Foundation

final class DetailRepositoryModel: DetailRepositoryModelInput {
    func fetchImage(from url: String?, completion: @escaping (Result<Data, ImageAPI.ImageError>) -> Void) {
        let api = ImageAPI()
        api.getImage(from: url) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
