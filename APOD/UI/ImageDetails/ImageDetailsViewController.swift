//
//  ImageDetailsViewController.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import UIKit

class ImageDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    /// Image Title
    @IBOutlet weak var imageTitle: UILabel!
    ///  Image's Date
    @IBOutlet weak var dateLabel: UILabel!
    /// Image
    @IBOutlet weak var imageView: UIImageView!
    /// Description of the Image
    @IBOutlet weak var imageDescriptionLabel: UILabel!
    /// Cancel to dismiss the view
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    /// Manage favourite button
    @IBOutlet weak var favouriteButton: UIBarButtonItem!

    // MARK: Properties
    
    /// Image Loader Inteface Type
    var imageLoader: ImageLoader?
    
    ///  Navigation delegates
    weak var dissmissImageDetailViewDelegate: DismissImageDetailViewDelegate?
    
    /// Image Model
    var imageViewModel: Image? {
        didSet {
            setPresentableDataToUIElements()
        }
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
        
    }
    /// Dismiss the Detail View
    @IBAction func cancelButtonPressed() {
        dissmissImageDetailViewDelegate?.dismissImageDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityView)
        activityView.startAnimating()
        
        imageLoader?.load { [weak self] result in
            switch result {
            case let .success(imageData):
                self?.imageViewModel = imageData
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
        dissmissImageDetailViewDelegate?.showAlertMessage(title: Constants.Error, message: Constants.Error_Description)
    }
    private func setPresentableDataToUIElements() {
        guard let imageViewModel = imageViewModel else  {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.imageTitle.text = imageViewModel.title
            self?.dateLabel.text = imageViewModel.date
            self?.imageDescriptionLabel.text = imageViewModel.description
            self?.loadImage()
        }
    }
    ///  Get the image from the URL received as response
    private func loadImage() {
        
        guard let imageViewModel = imageViewModel,
              imageViewModel.imageURL.absoluteString.isImage() else { return }
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            
            guard let imageData = try? Data(contentsOf: imageViewModel.imageURL),
                  let image = UIImage(data: imageData) else { return }
            DispatchQueue.main.async { [weak self ] in
                self?.imageView.image = image
                self?.activityView.stopAnimating()
            }
        }
    }
}
