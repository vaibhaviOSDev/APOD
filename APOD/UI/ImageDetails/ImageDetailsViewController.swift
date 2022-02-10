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
    
    /// Image Loader Inteface Type
    var imageLoader: ImageLoader?
    
    ///  Navigation delegates
    weak var imageDetailViewDelegate: ImageDetailViewDelegate?
    
    /// Image Model
    var imageViewModel: ImageViewModel? {
        didSet {
            setPresentableDataToUIElements()
        }
    }
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
    private func imageDetailsViewLoadingHandler() {
        guard imageViewModel == nil else { return }
        startActivityIndicator()
        imageLoader?.load { [weak self] result in
            switch result {
            case let .success(imageData):
                self?.imageViewModel = ImageViewModel(imageInfo: imageData, isFavourite: false)
            case .failure:
                self?.displayAlert()
            }
        }
    }
    // MARK: - Helpers
    
    /// When the error occurs the alert View is displayed
    private func displayAlert() {
        DispatchQueue.main.async { [weak self] in
            self?.activityView.stopAnimating()
        }
        imageDetailViewDelegate?.showAlertMessage(title: Constants.Error, message: Constants.Error_Description)
    }
    private func setPresentableDataToUIElements() {
        startActivityIndicator()
        guard let imageViewModel = imageViewModel else {
            stopActivityIndicator()
            return
        }
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
              imageViewModel.imageInfo.imageURL.absoluteString.isImage() else { return }
        startActivityIndicator()
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            
            guard let imageData = try? Data(contentsOf: imageViewModel.imageInfo.imageURL),
                  let image = UIImage(data: imageData) else { return }
            DispatchQueue.main.async { [weak self ] in
                self?.imageView.image = image
                self?.stopActivityIndicator()
            }
        }
    }
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
