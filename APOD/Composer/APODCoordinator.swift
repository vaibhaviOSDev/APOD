//
//  APODCoordinator.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 8.2.2022.
//

import Foundation
import UIKit

public final class APODCoordinator {
    
    // MARK: Properties
    
    weak var navigationController: UINavigationController?

    /// Search View Controller where a user selects a date of his choice & search the image of that day
    lazy var searchImageViewController: SearchImageViewController? = {
        guard let searchImageViewController = UIStoryboard(name: Constants.SearchImageViewNibName, bundle: nil).instantiateViewController(withIdentifier: Constants.SearchImageViewNibName) as? SearchImageViewController else { return nil }
        searchImageViewController.navigationDelegate = self
        return searchImageViewController
    }()
    
    /// Image Details View Controller where a user is displayed the details of the retrieved image
    var imageDetailsViewController: ImageDetailsViewController?
    
    /// Will display list of favourites
    lazy var favouritesListViewController: FavouritesListViewController? = {
        let favouritesListViewController = FavouritesListViewController()
        favouritesListViewController.navigationDelegate = self
        return favouritesListViewController
    }()

    /// Class which composes API and Persistence
    var remoteWithLocalFallBackImageLoader: RemoteWithLocalFallBackImageLoader?
    
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
