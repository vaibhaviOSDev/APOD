//
//  FavouritesListViewController.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import UIKit

final class FavouritesListViewController: UITableViewController {
    
    // MARK: - Properties
    weak var navigationDelegate: DisplayFavouriteDelegate?
    
    var imageLists: [ImageViewModel] = [ImageViewModel](){
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favourites"
        tableView.register(UINib(nibName: Constants.FavouriteImageCellNibName, bundle: nil), forCellReuseIdentifier: Constants.FavouriteImageCellIdentifier)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !imageLists.isEmpty ? imageLists.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FavouriteImageCellIdentifier, for: indexPath) as? FavouritesTableViewCell {
            cell.favouritesCellViewModel = imageLists[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: Table view delegate source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard imageLists.count > indexPath.row else { return }
        let imageViewModel = imageLists[indexPath.row]
        navigationDelegate?.displayDetailsOfFavourite(imageViewModel: imageViewModel)
    }

}
