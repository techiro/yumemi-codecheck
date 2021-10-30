//
//  SearchRepositoriesResponse.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/30.
//

import Foundation

struct SearchRepositoriesResponse: Decodable, Equatable {
    let items: [Repository]

    static func == (lhs: SearchRepositoriesResponse, rhs: SearchRepositoriesResponse) -> Bool {
        lhs.items == rhs.items
    }

}

#if DEBUG
extension SearchRepositoriesResponse {
    static func mock() -> SearchRepositoriesResponse {
        return SearchRepositoriesResponse(items: [
            Repository.mock()
        ])
    }
}
#endif
