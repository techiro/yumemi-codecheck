//
//  AlertViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by TanakaHirokazu on 2021/10/30.
//

import Foundation
import UIKit

class AlertView {

    func setAlert(title: String, message: String) -> UIAlertController {
        let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK")
        }

        alert.addAction(defaultAction)
        return alert
    }
}
