//
//  APODCoordinator.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 8.2.2022.
//

import Foundation
import UIKit

/// Protocol for presenting the Image Detail View when the user clicks on Search
protocol PresentImageDetailViewDelegate: AnyObject {
    func presentImageDetailsViewController(date: String)
}
/// Protocol for dismissing the Image Detail View when the user clicks on Cancel button
protocol DismissImageDetailViewDelegate: AnyObject {
    func dismissImageDetailView()
    func showAlertMessage(title: String, message: String)
}

class APODCoordinator {
    
    // MARK: Properties
    
    private weak var navigationController: UINavigationController?

    /// Search View Controller where a user selects a date of his choice & search the image of that day
    lazy var searchImageViewController: SearchImageViewController? = {
        guard let searchImageViewController = UIStoryboard(name: Constants.SearchImageViewID, bundle: nil).instantiateViewController(withIdentifier: Constants.SearchImageViewID) as? SearchImageViewController else { return nil }
        searchImageViewController.navigationDelegate = self
        return searchImageViewController
    }()
    
    /// Image Details View Controller where a user is displayed the details of the retrieved image
    private var imageDetailsViewController: ImageDetailsViewController?

    private var remoteWithLocalFallBackImageLoader: RemoteWithLocalFallBackImageLoader?
    
    // MARK: Init
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        guard let searchImageViewController = searchImageViewController,
              let navigationController = navigationController else { return }
        navigationController.pushViewController(searchImageViewController, animated: true)
    }
    // MARK: Helpers
    
    private func getURLForFetchingTheImageData(date: String) -> URL? {
        return URL(string: "\(Constants.API)api_key=\(Constants.API_KEY)&date=\(date)")
    }
    private func getRemoteWithLocalFallbackImageLoader(url: URL) -> RemoteWithLocalFallBackImageLoader {
        let remoteImageLoader = RemoteImageLoader(url: url)
        let localImageLoader = LocalImageLoader()
        let remoteWithLocalFallBackImageLoader = RemoteWithLocalFallBackImageLoader(
            remoteImageLoader: remoteImageLoader,
            localImageLoader: localImageLoader)
        
        return remoteWithLocalFallBackImageLoader
    }
}
extension APODCoordinator: PresentImageDetailViewDelegate {
    
    func presentImageDetailsViewController(date: String) {
        
        if imageDetailsViewController == nil {
            imageDetailsViewController = UIStoryboard(name: Constants.ImageDetailsViewID, bundle: nil).instantiateViewController(withIdentifier: Constants.ImageDetailsViewID) as? ImageDetailsViewController
        }
        guard let imageDetailsViewController = imageDetailsViewController,
              let navigationController = navigationController,
              let url = getURLForFetchingTheImageData(date: date) else { return }
        
        remoteWithLocalFallBackImageLoader = getRemoteWithLocalFallbackImageLoader(url: url)
        imageDetailsViewController.imageLoader = remoteWithLocalFallBackImageLoader
        imageDetailsViewController.dissmissImageDetailViewDelegate = self
        navigationController.present(imageDetailsViewController, animated: true, completion: nil)
    }
    
}

extension APODCoordinator: DismissImageDetailViewDelegate {
    
    func dismissImageDetailView() {
        imageDetailsViewController?.dismiss(animated: true, completion: nil)
        imageDetailsViewController = nil
    }
    func showAlertMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default) { [weak self] _  in
            self?.dismissImageDetailView()
        }
        alertController.addAction(alertAction)
        navigationController?.present(alertController, animated: false, completion: nil)
    }
}
