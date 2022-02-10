//
//  RemoteWithLocalFallBackImageLoader.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation


public final class RemoteWithLocalFallBackImageLoader {
    
    // MARK: - Properties
    
    private let remoteImageLoader: RemoteImageLoader
    private let localImageLoader: LocalImageLoader
    
    // MARK: - Init

    init(remoteImageLoader: RemoteImageLoader, localImageLoader: LocalImageLoader) {
        self.remoteImageLoader = remoteImageLoader
        self.localImageLoader = localImageLoader
    }
}
// MARK: - ImageDetailsLoader

extension RemoteWithLocalFallBackImageLoader: ImageDetailsLoader {
    
    /// This method on the basis of network reaachability  delegates the task of fetching the Image Details to respective loaders
    public func load(completion: @escaping (ImageDetailsLoaderResult) -> Void) {
        
        let result = Reachability.isConnectedToNetwork() ? remoteImageLoader.load : localImageLoader.load
        result(completion)
    }
}
extension RemoteWithLocalFallBackImageLoader: ImageLoader {
    
    /// This method on the basis of network reaachability  delegates the task of downloading the Image Details to respective loaders
    public func loadImage(completion: @escaping (ImageLoaderResult) -> Void) {
        
        let result = Reachability.isConnectedToNetwork() ? remoteImageLoader.loadImage : localImageLoader.loadImage
        result(completion)
    }
}
