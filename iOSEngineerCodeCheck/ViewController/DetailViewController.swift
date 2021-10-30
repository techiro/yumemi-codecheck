//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var languageLabel: UILabel!
    @IBOutlet weak private var starsLabel: UILabel!
    @IBOutlet weak private var watchersLabel: UILabel!
    @IBOutlet weak private var forksLabel: UILabel!
    @IBOutlet weak private var issuesLabel: UILabel!

    // swiftlint:disable implicitly_unwrapped_optional
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

        setUpImage()
    }

    func setUpImage() {
        ImageAPI().getImage(from: repository.owner?.avatarUrl) { [weak self] result in
            switch result {
            case .success(let data):
                let img = UIImage(data: data)
                DispatchQueue.main.async {
                    self?.imageView.image = img
                }
            case .failure(let error):
                switch error {
                case .dataError(let title):
                    self?.alert.setAlert(title: title, message: "")
                case .urlError(let title):
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
