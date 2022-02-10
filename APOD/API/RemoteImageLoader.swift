//
//  RemoteImageLoader.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

public final class RemoteImageLoader {
    
    // MARK: - Properties
    
    private var url: URL
    private let client: HTTPClient
    
    // MARK: - Errors

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    // MARK: - Init

    init(url: URL, client: HTTPClient = URLSession.shared) {
        self.url = url
        self.client = client
    }
}

// MARK: - ImageDetailsLoader Delegate
/// Fetched the image details using the NASA's API  key and URL

extension RemoteImageLoader: ImageDetailsLoader {

    public func load(completion: @escaping (ImageDetailsLoaderResult) -> Void) {
        
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                completion(ImageDataMapper.map(data, response))
                if let imageURL = ImageDataMapper.imageURL {
                    self?.url = imageURL
                }
            case .failure :
                completion(.failure(Error.connectivity))
            }
        }
    }
}
// MARK: - ImageLoader Delegate

/// Downloads the image
extension RemoteImageLoader: ImageLoader {
    
    public func loadImage(completion: @escaping (ImageLoaderResult) -> Void) {
        client.fetchImageFromServer(from: url) { [weak self] result in
            guard self != nil else { return }

            switch result {
                
            case let .success(localURL):
                if let imageData = ImageDataMapper.mapImageLocalURL(localURL: localURL) {
                    completion(.success(imageData))
                } else {
                    completion(.failure(Error.invalidData))
                }
            case .failure :
                completion(.failure(Error.connectivity))
            }
        }
    }
}

