//
//  ImageRepository.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 10.2.2022.
//

import Foundation
import CoreData

public struct ImageRepository {
    
    // MARK: - Insert
    
    /// When the Image is loaded from the network it is then stored locally using this method.
    public func createAPODEntity(imageViewModel: ImageViewModel) {
        cleanUpBeforeCreation()
        let context: NSManagedObjectContext = CoreDataStack.shared.context
        
        let imageInfo: ImageInfo = ImageInfo(context: context)
        imageInfo.title = imageViewModel.imageInfo.title
        imageInfo.date = imageViewModel.imageInfo.date
        imageInfo.imageDescription = imageViewModel.imageInfo.description
        imageInfo.imageData = imageViewModel.imageData
        imageInfo.imageURL = imageViewModel.imageInfo.imageURL?.absoluteString ?? ""
        CoreDataStack.shared.saveContext()
    }
    // MARK: - Fetch

    public func getImageDetails() -> ImageViewModel? {
        
        var imageViewModels: [ImageViewModel] = [ImageViewModel]()
        let imageRecords = CoreDataStack.shared.fetchRequest(managedObject: ImageInfo.self)
        
        imageRecords?.forEach { imageInfo  in
            if let imageViewModel = imageInfo.convertToImageViewModel(){
                imageViewModels.append(imageViewModel)
            }
        }
        return !imageViewModels.isEmpty ? imageViewModels.first : nil 
    }
    // MARK: - Clean Up

    /// Is executed before every Insert just to ensure the most recent one is displayed to the user
    private func cleanUpBeforeCreation() {
        let managedObjectContext: NSManagedObjectContext = CoreDataStack.shared.context
        let request: NSFetchRequest<ImageInfo> = ImageInfo.fetchRequest()
        do {
            guard let record = try managedObjectContext.fetch(request).first else {
                return
            }
            managedObjectContext.delete(record)

        } catch let error {
            debugPrint(error.localizedDescription)
        }
    }
}
