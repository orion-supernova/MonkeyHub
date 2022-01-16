//
//  AlertWithUIKit.swift
//  MonkeyHub
//
//  Created by Murat Can KOÇ on 28.05.2021.
//

import UIKit

class Helper {

    static var app: Helper = {
        return Helper()

    }()
    var APNS_Token = ""

    func alertMessage(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_: UIAlertAction) in
        }
        alertVC.addAction(okAction)

        let viewController = UIApplication.shared.windows.first!.rootViewController!
        viewController.present(alertVC, animated: true, completion: nil)
    }

    func slangAlertMessage(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Sg aq", style: .default) { (_: UIAlertAction) in
        }
        alertVC.addAction(okAction)

        let viewController = UIApplication.shared.windows.first!.rootViewController!
        viewController.present(alertVC, animated: true, completion: nil)
    }

}
