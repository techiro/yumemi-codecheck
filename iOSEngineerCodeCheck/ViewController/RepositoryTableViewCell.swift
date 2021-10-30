//
//  RepositoryTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/29.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var detail: UILabel!

    var repository: Repository? {
        didSet {
            guard let repository = repository else {
                return
            }
            title.text = repository.fullName
            detail.text = repository.language
        }
    }

}
