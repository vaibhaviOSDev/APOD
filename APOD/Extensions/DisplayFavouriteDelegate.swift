//
//  DisplayFavouriteDelegate.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 10.2.2022.
//

import UIKit

// MARK: - DisplayFavouriteDelegate

public protocol DisplayFavouriteDelegate: AnyObject {
    func displayDetailsOfFavourite(imageViewModel: ImageViewModel)
}
/// Presents the User the lists of all the Images marked as favourite
extension APODCoordinator: DisplayFavouriteDelegate {
    public func displayDetailsOfFavourite(imageViewModel: ImageViewModel) {

        if imageDetailsViewController == nil {
            imageDetailsViewController = UIStoryboard(name: Constants.ImageDetailsViewNibName, bundle: nil).instantiateViewController(withIdentifier: Constants.ImageDetailsViewNibName) as? ImageDetailsViewController
        }
        guard let imageDetailsViewController = imageDetailsViewController,
              let imageURL = imageViewModel.imageInfo.imageURL else { return }

        imageDetailsViewController.imageViewModel = imageViewModel
        imageDetailsViewController.imageLoader = APODFactory.getRemoteWithLocalFallbackImageLoader(url: imageURL)
        imageDetailsViewController.imageDetailViewDelegate = self
        navigationController?.present(imageDetailsViewController, animated: true, completion: nil)
    }
}
