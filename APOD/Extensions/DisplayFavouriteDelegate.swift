//
//  DisplayFavouriteDelegate.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 10.2.2022.
//

import UIKit

public protocol DisplayFavouriteDelegate: AnyObject {
    func displayDetailsOfFavourite(imageViewModel: ImageViewModel)
}
extension APODCoordinator: DisplayFavouriteDelegate {
    public func displayDetailsOfFavourite(imageViewModel: ImageViewModel) {

        if imageDetailsViewController == nil {
            imageDetailsViewController = UIStoryboard(name: Constants.ImageDetailsViewNibName, bundle: nil).instantiateViewController(withIdentifier: Constants.ImageDetailsViewNibName) as? ImageDetailsViewController
        }
        guard let imageDetailsViewController = imageDetailsViewController else { return }
        imageDetailsViewController.imageViewModel = imageViewModel
        imageDetailsViewController.imageDetailViewDelegate = self
        navigationController?.present(imageDetailsViewController, animated: true, completion: nil)
    }
}