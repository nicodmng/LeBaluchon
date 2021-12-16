//
//  Alert.swift
//  LeBaluchonV2
//
//  Created by Nicolas Demange on 08/12/2021.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alertController: UIAlertController = .init(title: "Erreur", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
}
