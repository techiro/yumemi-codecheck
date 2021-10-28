//
//  URL+Extension.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/28.
//

import Foundation

extension URL {
    func queryItemAdded(name: String, value: String?) -> URL? {
        return self.queryItemsAdded([URLQueryItem(name: name, value: value)])
    }

    func queryItemsAdded(_ queryItems: [URLQueryItem]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: nil != self.baseURL) else {
            return nil
        }
        components.queryItems = queryItems + (components.queryItems ?? [])
        return components.url
    }
}
