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
    var alert = AlertViewController()
    var repositories: [Repository] = []
    var index: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        alert.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            guard let detailVC = segue.destination as? DetailViewController else { return }
            detailVC.repository = repositories[index]
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

        GitHubAPI().fetchRepositories(word: word) { [weak self] result in
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

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Repository", for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }

        let repository = repositories[indexPath.row]
        cell.repository = repository
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
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
