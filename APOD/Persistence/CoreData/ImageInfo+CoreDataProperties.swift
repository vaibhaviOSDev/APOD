//
//  ImageInfo+CoreDataProperties.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 10.2.2022.
//
//

import Foundation
import CoreData


extension ImageInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageInfo> {
        return NSFetchRequest<ImageInfo>(entityName: "ImageInfo")
    }

    @NSManaged public var imageData: Data?
    @NSManaged public var imageDescription: String?
    @NSManaged public var date: String?
    @NSManaged public var title: String?
    @NSManaged public var imageURL: String?

}

extension ImageInfo : Identifiable {
    func convertToImageViewModel()-> ImageViewModel?{
        
        guard let title = title,
              let date = date,
              let imageDescription = imageDescription,
              let imageData = imageData,
              let imageURL = imageURL else { return nil }

        let image = Image(
            title: title,
            date: date,
            imageURL: URL(string: imageURL),
            description: imageDescription)
        
        return ImageViewModel(imageInfo: image, isFavourite: false, imageData: imageData)
    }
}
