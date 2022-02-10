//
//  FavouritesTableViewCell.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import UIKit

final class FavouritesTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties

    var favouritesCellViewModel: ImageViewModel? {
        didSet {
            titleLabel.text = favouritesCellViewModel?.imageInfo.title
            dateLabel.text = favouritesCellViewModel?.imageInfo.date
        }
    }
}
