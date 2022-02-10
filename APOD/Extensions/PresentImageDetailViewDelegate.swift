//
//  APODCoordinator+SearchImageDelegate.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 10.2.2022.
//

import UIKit

// MARK: - PresentImageDetailViewDelegate

/// Protocol for presenting the Image Detail View when the user clicks on Search
public protocol PresentImageDetailViewDelegate: AnyObject, DisplayAlertDelegate {
    func presentImageDetailsViewController(date: String)
    func displayListOfFavourites()
}

/// Manages all the events for SearchImageViewController which is the Landing Page
extension APODCoordinator: PresentImageDetailViewDelegate {
    
    /// Manages the logic of passing the date selected by the user to the composer
    public func presentImageDetailsViewController(date: String) {
     
        guard !isImageAlreadyAddedToFavouritesList(date: date),
              let imageDetailsViewController = getImageDetailsViewController(),
              let navigationController = navigationController,
              let url = getURLForFetchingTheImageData(date: date) else {
        
            showAlertMessage(title: Constants.AlreadyInFavourites, message: Constants.GoToFavourites)
            return
        }
        
       let remoteWithLocalFallBackImageLoader = APODFactory.getRemoteWithLocalFallbackImageLoader(url: url)
        imageDetailsViewController.imageDetailsLoader = remoteWithLocalFallBackImageLoader
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
    
    /// Prepare URL for fetching the Image details
    private func getURLForFetchingTheImageData(date: String) -> URL? {
        return URL(string: "\(Constants.API)api_key=\(Constants.API_KEY)&date=\(date)")
    }
    
    /// Initialising the ImageDetailsViewController
    private func getImageDetailsViewController() -> ImageDetailsViewController? {
        imageDetailsViewController = UIStoryboard(name: Constants.ImageDetailsViewNibName, bundle: nil).instantiateViewController(withIdentifier: Constants.ImageDetailsViewNibName) as? ImageDetailsViewController
        return imageDetailsViewController
    }
    /// Manages the logic of appending/ deleting the lists of Favourites
    private func isImageAlreadyAddedToFavouritesList(date: String) -> Bool {
        var imageExistInFavouriteList: Bool = false
        guard let favouritesListViewController = favouritesListViewController,
              !favouritesListViewController.imageLists.isEmpty else {
            return imageExistInFavouriteList
        }
        let imagesList = favouritesListViewController.imageLists
        for image in imagesList {
            if image.imageInfo.date == date {
                imageExistInFavouriteList = true
                break
            }
        }
        return imageExistInFavouriteList
    }
}
