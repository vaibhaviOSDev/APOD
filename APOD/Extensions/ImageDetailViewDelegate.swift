//
//  ImageDetailViewDelegate.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 10.2.2022.
//

import UIKit

// MARK: - ImageDetailViewDelegate

/// Protocol for dismissing the Image Detail View when the user clicks on Cancel button
public protocol ImageDetailViewDelegate: AnyObject, DisplayAlertDelegate {
    func dismissImageDetailView()
    func manageFavourite(imageViewModel: ImageViewModel)
    func persistDataToLoadWhenOffline(imageViewModel: ImageViewModel)
}

/// Manages all the events for ImageDetailView which is presented to the user when he performs search
extension APODCoordinator: ImageDetailViewDelegate {
    
    public func dismissImageDetailView() {
        imageDetailsViewController?.dismiss(animated: true, completion: nil)
        imageDetailsViewController = nil
    }
    /// Manages the logic of maintaining states for the Images marked/ unmarked as favourite
    public func manageFavourite(imageViewModel: ImageViewModel) {
        guard let favouritesListViewController = favouritesListViewController else {
            return
        }
        let imageList = favouritesListViewController.imageLists

        var imageAlreadyMarkedAsFavourite: Bool = false
        var indexOfFoundElement: Int = 0
        for i in 0..<imageList.count {
            if imageViewModel.imageInfo.date == imageList[i].imageInfo.date {
                imageAlreadyMarkedAsFavourite = true
                indexOfFoundElement = i
                break
            }
        }
        if imageViewModel.isFavourite {
            guard !imageAlreadyMarkedAsFavourite else { return }
            favouritesListViewController.imageLists.append(imageViewModel)
        } else {
            guard imageAlreadyMarkedAsFavourite else { return }
            favouritesListViewController.imageLists.remove(at: indexOfFoundElement)
        }
    }
    public func persistDataToLoadWhenOffline(imageViewModel: ImageViewModel) {
        let imageRepository = APODFactory.getImageRepository()
        imageRepository.createAPODEntity(imageViewModel: imageViewModel)
    }
}
