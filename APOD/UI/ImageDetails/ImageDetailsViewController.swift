//
//  ImageDetailsViewController.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import UIKit

final class ImageDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    /// Image Title
    @IBOutlet weak var imageTitle: UILabel!
    /// Image's Date
    @IBOutlet weak var dateLabel: UILabel!
    /// Image
    @IBOutlet weak var imageView: UIImageView!
    /// Description of the Image
    @IBOutlet weak var imageDescriptionLabel: UILabel!
    /// Cancel to dismiss the view
    @IBOutlet weak var closeButton: UIBarButtonItem!
    /// Manage favourite button
    @IBOutlet weak var favouriteButton: UIButton!

    // MARK: Properties
    
    /// Image Details Loader Inteface Type
    var imageDetailsLoader: ImageDetailsLoader?
    
    /// Image  Loader Inteface Type
    var imageLoader: ImageLoader?
    
    ///  Navigation delegates
    weak var imageDetailViewDelegate: ImageDetailViewDelegate?
    
    /// Image Model
    var imageViewModel: ImageViewModel? {
        didSet {
            setPresentableDataToUIElements()
        }
    }
    /// Local variable for deciding the image on the basis of whether the user has marked it as favoruite or not
    private var isFavourite: Bool = false
    
    /// Image Icon Name
    private var favouriteIcon: UIImage? {
        return isFavourite ? UIImage(named: Constants.FavouriteIconName) :
                            UIImage(named: Constants.NotFavouriteIconName)
    }
    /// Activity View to indicate that the content is loading
    lazy var activityView: UIActivityIndicatorView = {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        return activityView
    }()
    
    // MARK: - IBActions

    /// Mark Image As Favourite
    @IBAction func markAsFavourite() {
        
        guard var imageViewModel = imageViewModel else { return }
        
        imageViewModel.isFavourite = !imageViewModel.isFavourite
        isFavourite = imageViewModel.isFavourite
        if let favouriteIcon = favouriteIcon {
            favouriteButton.setBackgroundImage(favouriteIcon, for: UIControl.State.normal)
        }
        
        imageDetailViewDelegate?.manageFavourite(imageViewModel: imageViewModel)
    }
    /// Dismiss the Detail View
    @IBAction func cancelButtonPressed() {
        imageDetailViewDelegate?.dismissImageDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityView)
        imageDetailsViewLoadingHandler()
    }
    // MARK: - Helpers
    
    /// Image details are being retrieved either from Network or Persistence layer depending upon the Network reachability
    private func imageDetailsViewLoadingHandler() {
        
        guard imageViewModel == nil else { return }
        
        startActivityIndicator()
        
        imageDetailsLoader?.load { [weak self] result in
            
            switch result {
                
            case let .success(imageViewModel):
                self?.imageViewModel = imageViewModel
                
            case let .failure(error):
                self?.displayAlert(description: error.localizedDescription)
            }
        }
    }
    
    /// When the error occurs the alert View is displayed
    private func displayAlert(description: String) {
        DispatchQueue.main.async { [weak self] in
            self?.activityView.stopAnimating()
        }
        imageDetailViewDelegate?.showAlertMessage(title: Constants.Error, message: description)
    }
    /// Called when the ViewModel is set by other objects
    private func setPresentableDataToUIElements() {
        
        startActivityIndicator()
        
        guard let imageViewModel = imageViewModel else {
            stopActivityIndicator()
            return
        }
        isFavourite = imageViewModel.isFavourite
        
        DispatchQueue.main.async { [weak self] in
            self?.imageTitle.text = imageViewModel.imageInfo.title
            self?.dateLabel.text = imageViewModel.imageInfo.date
            self?.imageDescriptionLabel.text = imageViewModel.imageInfo.description
            if let favouriteIcon = self?.favouriteIcon {
                self?.favouriteButton.setBackgroundImage(favouriteIcon, for: UIControl.State.normal)
            }
            self?.loadImage()
        }
    }
    ///  Get the image from the URL received as response
    private func loadImage() {
        
        guard let imageViewModel = imageViewModel,
              let imageURL = imageViewModel.imageInfo.imageURL,
              imageURL.absoluteString.isImage() else {
            stopActivityIndicator()
            return
        }
        startActivityIndicator()
        
        imageLoader?.loadImage { [weak self] result in
          
           switch result {
               
           case let .success(imageData):
               self?.setImageWithData(data: imageData)
               
           case let .failure(error):
               self?.displayAlert(description: error.localizedDescription)
           }
        }
    }
    /// Initialises the Image and triggers the event of storing the full image details locally
    private func setImageWithData(data: Data) {
        DispatchQueue.main.async { [weak self ] in
            self?.imageView.image = UIImage(data: data)
            self?.stopActivityIndicator()
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard var imageViewModel = self?.imageViewModel else {
                    return
                }
                imageViewModel.imageData = data
                self?.imageDetailViewDelegate?.persistDataToLoadWhenOffline(imageViewModel: imageViewModel)
            }
        }
    }
    // MARK: - Activity Handler
    
    private func startActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let activityView = self?.activityView,
                  !activityView.isAnimating else { return }
            activityView.startAnimating()
        }
    }
    private func stopActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            guard let activityView = self?.activityView,
                  activityView.isAnimating else { return }
            activityView.stopAnimating()
        }
    }
}
