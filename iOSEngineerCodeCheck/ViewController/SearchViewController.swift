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

    var repositorys: [[String: Any]] = []

    var task: URLSessionTask?
    var word: String = ""
    var url: String!
    var index: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // TODO: 検索バーの初期値はなし、プレースホルダーで示してあげる。
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        word = searchBar.text!

        if !word.isEmpty {
            url = "https://api.github.com/search/repositories?q=\(word)"
            // TODO: 文字列デコード

            task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
                do {
                    if let obj = try JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                        if let items = obj["items"] as? [[String: Any]] {
                            self.repositorys = items
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                } catch {
                    print(error)
                }

            }
            // これ呼ばなきゃリストが更新されません
            task?.resume()
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "Detail"{
            let detailVC = segue.destination as! DetailViewController
            detailVC.searchVC = self
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositorys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        let rp = repositorys[indexPath.row]
        cell.textLabel?.text = rp["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = rp["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell

    }

    // MARK: 画面遷移
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "Detail", sender: self)

    }

}
