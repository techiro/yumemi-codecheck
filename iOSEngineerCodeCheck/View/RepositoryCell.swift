//
//  RepositoryCell.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/11/07.
//

import UIKit

final class RepositoryCell: UITableViewCell {
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    func setup(repository: Repository) {
        setupImage(repository: repository)
        DispatchQueue.main.async {
            self.nameLabel.text = repository.fullName
            self.languageLabel.text = repository.language
        }
    }

    func setupImage(repository: Repository) {
        ImageAPI().getImage(from: repository.owner?.avatarUrl) { [weak self] result in
            switch result {
            case .success(let data):
                let img = UIImage(data: data)
                DispatchQueue.main.async { [weak self] in
                    self?.iconImageView?.image = img

                }
            case .failure(let error):
                switch error {
                case .dataError(let title):
                    print(title)
                case .urlError(let title):
                    print(title)

                }
            }
        }
    }
}
