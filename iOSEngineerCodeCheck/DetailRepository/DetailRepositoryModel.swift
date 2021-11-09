//
//  DetailRepositoryModel.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/11/09.
//

import Foundation

protocol DetailRepositoryModelInput {
    func fetchImage(from: String?, completion: @escaping (Result<Data, ImageAPI.ImageError>) -> Void)
}
final class DetailRepositoryModel: DetailRepositoryModelInput {
    func fetchImage(from: String?, completion: @escaping (Result<Data, ImageAPI.ImageError>) -> Void) {
        let api = ImageAPI()

    }

}
