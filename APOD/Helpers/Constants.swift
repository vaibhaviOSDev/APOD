//
//  Constants.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

struct Constants {
    
    static let SearchImageViewNibName = "SearchImageViewController"
    static let ImageDetailsViewNibName = "ImageDetailsViewController"
    
    static let FavouriteImageCellNibName = "FavouritesTableViewCell"
    static let FavouriteImageCellIdentifier = "ImageInfo"
    static let FavouriteIconName = "mark"
    static let NotFavouriteIconName = "unmark"

    static let API_KEY = "WFVTwvBHNihnrS6LFr5QJpNImgKOTOeuUElfdzXe"
    static let API = "https://api.nasa.gov/planetary/apod?"
    
    static let DateFormat = "yyyy-MM-dd"
    static let Error = "Error"
    static let Error_Description = ""
    static let No_Favourites = "No Favourites"
    static let No_Favourites_Message = "Kindly mark one or more images as favourites to view the list"

}
