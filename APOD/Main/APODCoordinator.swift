//
//  APODCoordinator.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 8.2.2022.
//

import Foundation
import UIKit

class APODCoordinator {
    
    // MARK: Properties
    
    private weak var navigationController: UINavigationController?

    lazy var searchImageViewController: SearchImageViewController? = {
        guard let searchImageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchImageViewController") as? SearchImageViewController else { return nil }
        return searchImageViewController
    }()
    
    // MARK: Init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Start
    
    func start() {
        guard let searchImageViewController = searchImageViewController,
              let navigationController = navigationController else { return }
        navigationController.pushViewController(searchImageViewController, animated: false)
    }
}

