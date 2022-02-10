//
//  LocalImageLoader.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

public final class LocalImageLoader {}

// MARK: - ImageDetailsLoader

/// When user is offline the record which is persisted using the CoreData framework is retrieved & sent as completion
extension LocalImageLoader: ImageDetailsLoader {
    
    public func load(completion: @escaping (ImageDetailsLoaderResult) -> Void) {
        let imageRepository = APODFactory.getImageRepository()
        
        if let imageViewModel = imageRepository.getImageDetails() {
            completion(.success(imageViewModel))
        } else {
            let error = NSError(domain: "No Records Found", code: 0)
            completion(.failure(error))
        }
    }
}

// MARK: - ImageLoader

/// When user is offline the image data which is persisted using the CoreData framework is retrieved & sent as completion
extension LocalImageLoader: ImageLoader {
    public func loadImage(completion: @escaping (ImageLoaderResult) -> Void) {
        let imageRepository = APODFactory.getImageRepository()
        
        if let imageViewModel = imageRepository.getImageDetails(),
           let data = imageViewModel.imageData {
            completion(.success(data))
        } else {
            let error = NSError(domain: "No Records Found", code: 0)
            completion(.failure(error))
        }
    }
}
