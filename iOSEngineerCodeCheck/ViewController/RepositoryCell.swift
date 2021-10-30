//
//  RepositoryTableViewCell.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/29.
//

import UIKit

class RepositoryCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: "RepositoryCell")
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
