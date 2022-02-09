//
//  FavouritesTableViewCell.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    var favouritesCellViewModel: Image? {
        didSet {
            titleLabel.text = favouritesCellViewModel?.title
            dateLabel.text = favouritesCellViewModel?.date
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
