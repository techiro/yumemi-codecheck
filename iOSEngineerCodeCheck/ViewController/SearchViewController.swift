//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
class SearchViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!

    var repositories: [Repository] = []
    var index: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail"{
            let detailVC = segue.destination as! DetailViewController
            detailVC.repository = repositories[index]
        }
    }

}

// MARK: 検索機能
extension SearchViewController {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        guard let word = searchBar.text else { return }
        GitHubAPI.fetchRepositories(word: word) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.repositories = repositories.items
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self?.displayAlert()
            }
        }
        self.view.endEditing(true)
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

extension SearchViewController {
    func displayAlert() {
        let alert: UIAlertController = UIAlertController(title: "ネットワークエラー", message: "もう一度検索してください", preferredStyle: .alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK")
        }

        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
