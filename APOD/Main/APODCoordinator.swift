//
//  APODCoordinator.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 8.2.2022.
//

import Foundation
import UIKit

/// Protocol for presenting the Image Detail View when the user clicks on Search
protocol NavigationDelegate: AnyObject {
    func presentImageDetailsViewController(date: String)
}

class APODCoordinator {
    
    // MARK: Properties
    
    private weak var navigationController: UINavigationController?

    /// Search View Controller where a user selects a date of his choice & search the image of that day
    lazy var searchImageViewController: SearchImageViewController? = {
        guard let searchImageViewController = UIStoryboard(name: "SearchImageViewController", bundle: nil).instantiateViewController(withIdentifier: "SearchImageViewController") as? SearchImageViewController else { return nil }
        return searchImageViewController
    }()
    
    /// Image Details View Controller where a user is displayed the details of the retrieved image
    lazy var imageDetailsViewController: ImageDetailsViewController? = {
        guard let imageDetailsViewController = UIStoryboard(name: "ImageDetailsViewController", bundle: nil).instantiateViewController(withIdentifier: "ImageDetailsViewController") as? ImageDetailsViewController else { return nil }
        return imageDetailsViewController
    }()
    
    // MARK: Init
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        guard let searchImageViewController = searchImageViewController,
              let navigationController = navigationController else { return }
        searchImageViewController.navigationDelegate = self
        navigationController.pushViewController(searchImageViewController, animated: false)
    }
}
extension APODCoordinator: NavigationDelegate {
    func presentImageDetailsViewController(date: String) {
        guard let imageDetailsViewController = imageDetailsViewController,
              let navigationController = navigationController else { return }
        navigationController.present(imageDetailsViewController, animated: true, completion: nil)
    }
}


