//
//  AlertViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/30.
//

import Foundation
import UIKit

protocol UIAlertDelegate: AnyObject {
    func displayAlert(alert: UIAlertController)
}

class AlertViewController {
    weak var delegate: UIAlertDelegate?

    func setAlert(title: String, message: String) {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK")
        }

        alert.addAction(defaultAction)
        delegate?.displayAlert(alert: alert)
    }
}
