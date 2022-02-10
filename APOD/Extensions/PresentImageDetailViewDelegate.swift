//
//  APODCoordinator+SearchImageDelegate.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 10.2.2022.
//

import UIKit

/// Protocol for presenting the Image Detail View when the user clicks on Search
public protocol PresentImageDetailViewDelegate: AnyObject {
    func presentImageDetailsViewController(date: String)
    func displayListOfFavourites()
}

extension APODCoordinator: PresentImageDetailViewDelegate {
    
    public func presentImageDetailsViewController(date: String) {
     
        guard let imageDetailsViewController = getImageDetailsViewController(),
              let navigationController = navigationController,
              let url = getURLForFetchingTheImageData(date: date) else { return }
        
        remoteWithLocalFallBackImageLoader = getRemoteWithLocalFallbackImageLoader(url: url)
        imageDetailsViewController.imageLoader = remoteWithLocalFallBackImageLoader
        imageDetailsViewController.imageDetailViewDelegate = self
        navigationController.present(imageDetailsViewController, animated: true, completion: nil)
    }
    public func displayListOfFavourites() {
        guard let favouritesListViewController = favouritesListViewController,
              !favouritesListViewController.imageLists.isEmpty else {
                  showAlertMessage(title: Constants.No_Favourites, message: Constants.No_Favourites_Message)
            return
        }
        navigationController?.pushViewController(favouritesListViewController, animated: true)
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
    private func getImageDetailsViewController() -> ImageDetailsViewController? {
        imageDetailsViewController = UIStoryboard(name: Constants.ImageDetailsViewNibName, bundle: nil).instantiateViewController(withIdentifier: Constants.ImageDetailsViewNibName) as? ImageDetailsViewController
        return imageDetailsViewController
    }
}
