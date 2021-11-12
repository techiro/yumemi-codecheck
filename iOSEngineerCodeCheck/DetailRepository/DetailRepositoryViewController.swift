//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class DetailRepositoryViewController: UIViewController {

    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var languageLabel: UILabel!
    @IBOutlet weak private var starsLabel: UILabel!
    @IBOutlet weak private var watchersLabel: UILabel!
    @IBOutlet weak private var forksLabel: UILabel!
    @IBOutlet weak private var issuesLabel: UILabel!

    private var presenter: DetailRepositoryPresenterInput!

    func inject(presenter: DetailRepositoryPresenterInput) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter.fetchImage()
    }

    func setup() {
        titleLabel.text = presenter.fullName
        languageLabel.text = presenter.language
        starsLabel.text = presenter.starsCount
        watchersLabel.text = presenter.wachersCount
        forksLabel.text = presenter.forksCount
        issuesLabel.text = presenter.openIssuesCounts
    }
}

extension DetailRepositoryViewController: DetailRepositoryPresenterOutput {
    func showAlert(_ alert: UIAlertController) {
        present(alert, animated: true, completion: nil)
    }

    func setImage(image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.imageView.image = image
        }

    }
}
