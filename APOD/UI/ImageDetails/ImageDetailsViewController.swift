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
    @IBOutlet weak var date: UILabel!
    /// Image
    @IBOutlet weak var imageView: UIImageView!
    /// Description of the Image
    @IBOutlet weak var imageDescription: UILabel!
    /// Mark as Favourite Button
    @IBOutlet weak var favouriteButton: UIBarButtonItem!
    /// Dismiss Detail View Button
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    // MARK: - IBAction
    
    @IBAction func markAsFavourite() {
        
    }
    @IBAction func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
