//
//  GithubAPITests.swift
//  iOSEngineerCodeCheckTests
//
//  Created by TanakaHirokazu on 2021/10/29.
//
import Foundation
@testable import iOSEngineerCodeCheck
import XCTest

class GitHubAPITests: XCTestCase {

    // swiftlint:disable implicitly_unwrapped_optional
    var githubAPI: MockGitHubAPI!

    override func setUp() {
        super.setUp()
        githubAPI = MockGitHubAPI()
    }
    func test_fetchItemsIsEqualToMockItems() {
        githubAPI.fetchRepositories(word: "") {  result in
            switch result {
            case .success(let items):            XCTAssertEqual(items, SearchRepositoriesResponse.mock())
            case .failure(_):
                fatalError("Not Equal")
            }
        }

    }

    func test_whenFailStatuscodeError() {
        githubAPI.isSuccess = false
        githubAPI.fetchRepositories(word: "") { result in
            switch result {
            case .success(_): break
            case .failure(let error):
                switch error {
                case .statusCode(let message):
                    XCTAssertEqual(message, "mock statusError")

                default:
                    fatalError("Not statusError")
                }
            }
        }
    }
}
