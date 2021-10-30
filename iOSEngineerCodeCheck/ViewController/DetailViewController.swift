//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var watchersLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!

    var repository: Repository!
    var alert = AlertViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        alert.delegate = self
        titleLabel.text = repository.fullName
        languageLabel.text = "Written in \(repository.language ?? "")"
        starsLabel.text = "\(repository.stargazersCount ?? 0) stars"
        watchersLabel.text = "\(repository.wachersCount ?? 0) watchers"
        forksLabel.text = "\(repository.forksCount ?? 0) forks"
        issuesLabel.text = "\(repository.openIssuesCount ?? 0) open issues"

        ImageAPI().getImage(from: repository.owner?.avatarUrl) { [weak self] result in
            switch result {
            case .success(let data):
                let img = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.imageView.image = img
                }
            case .failure(let error):
                switch error {
                case .DataError(let title):
                    self?.alert.setAlert(title: title, message: "")
                case .URLError(let title):
                    self?.alert.setAlert(title: title, message: "")
                }
            }
        }
    }

}

extension DetailViewController: UIAlertDelegate {
    func displayAlert(alert: UIAlertController) {
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
