//
//  FavouritesListViewController.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import UIKit

class FavouritesListViewController: UITableViewController {

    // MARK: - Properties
    var imageLists: [Image]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: Constants.FavouriteImageCellNibName, bundle: nil), forCellReuseIdentifier: Constants.FavouriteImageCellIdentifier)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let imageLists = imageLists else {
            return  0
        }
        return imageLists.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FavouriteImageCellIdentifier, for: indexPath) as? FavouritesTableViewCell {
            if let imageLists = imageLists {
                cell.favouritesCellViewModel = imageLists[indexPath.row]
            }
            return cell
        }
        return UITableViewCell()
    }

}
