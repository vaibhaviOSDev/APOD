//
//  DisplayAlertDelegate.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 10.2.2022.
//

import UIKit

// MARK: - DisplayAlertDelegate

public protocol DisplayAlertDelegate {
    func showAlertMessage(title: String, message: String)
}
extension APODCoordinator: DisplayAlertDelegate {
    
    public func showAlertMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: Constants.OK, style: .default) { [weak self] _  in
            self?.dismissImageDetailView()
        }
        alertController.addAction(alertAction)
        navigationController?.present(alertController, animated: false, completion: nil)
    }
}
