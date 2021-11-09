//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
class SearchViewController: UITableViewController {

    @IBOutlet weak private var searchBar: UISearchBar!
    private var alert = AlertViewController()
    private var repositories: [Repository] = []
    // swiftlint:disable implicitly_unwrapped_optional
    private var selectedRepository: Repository!
    private var apiRequest: GitHubAPIProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        alert.delegate = self
        self.tableView.register(RepositoryCell.self, forCellReuseIdentifier: "RepositoryCell")
        self.apiRequest = GitHubAPI()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            guard let detailVC = segue.destination as? DetailViewController else { return }
            detailVC.repository = selectedRepository
        }
    }

}

// MARK: 検索機能
extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let word = searchBar.text else { return }

        apiRequest.fetchRepositories(word: word) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories.items
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                switch error {
                case .statusCode(let title):
                    self?.alert.setAlert(title: title, message: "もう一度検索してください")

                case .parse(let title):
                    self?.alert.setAlert(title: title, message: "もう一度検索してください")
                }
            }
            DispatchQueue.main.async {
                self?.view.endEditing(true)
            }

        }
    }
}

// MARK: テーブルView
extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let repository = repositories[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell", for: indexPath)
        cell.textLabel?.text = repository.fullName
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = repository.language
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRepository = repositories[indexPath.row]
        performSegue(withIdentifier: "Detail", sender: self)
        self.view.endEditing(true)
    }
}

// MARK: Alertを表示
extension SearchViewController: UIAlertDelegate {

    func displayAlert(alert: UIAlertController) {
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}