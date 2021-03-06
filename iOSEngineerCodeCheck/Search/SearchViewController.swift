//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var tableView: UITableView!
    private var presenter: SearchInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // Dependency Injection 依存関係の注入
    func inject(presenter: SearchInput) {
        self.presenter = presenter
    }

    private func setup() {
        self.title = "SearchRepository"
        // MARK: StoryboardのOutlet
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = 100
        tableView.register(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
    }

}

extension SearchViewController: SearchPresenterOutput {
    func showAlert(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }

    func presentDetail(at index: IndexPath) {
        let detailVC = UIStoryboard(
            name: "Detail",
            bundle: nil)
            .instantiateInitialViewController() as! DetailViewController

        let detailPresenter = DetailPresenter(view: detailVC, repository: presenter.repository(index: index), model: DetailModel())
        detailVC.inject(presenter: detailPresenter)

        navigationController?.pushViewController(detailVC, animated: true)
    }

    func updateRepositories(_ repositories: [Repository]) {
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectRow(at: indexPath)
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.selectRow(at: indexPath)
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell") as! RepositoryCell
        let repository = presenter.repository(index: indexPath)
        cell.setup(repository: repository)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRepositories
    }

}

// MARK: 検索バー
extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.tap(searchBar)
    }
}
