//
//  RemoteWithLocalFallBackImageLoader.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

public final class RemoteWithLocalFallBackImageLoader {

    private let remoteImageLoader: RemoteImageLoader
    private let localImageLoader: LocalImageLoader
    
    init(remoteImageLoader: RemoteImageLoader, localImageLoader: LocalImageLoader) {
        self.remoteImageLoader = remoteImageLoader
        self.localImageLoader = localImageLoader
    }
}
extension RemoteWithLocalFallBackImageLoader: ImageDetailsLoader {
    
    public func load(completion: @escaping (ImageDetailsLoaderResult) -> Void) {
        
        let result = Reachability.isConnectedToNetwork() ? remoteImageLoader.load : localImageLoader.load
        result(completion)
    }
}
extension RemoteWithLocalFallBackImageLoader: ImageLoader {
    
    public func loadImage(completion: @escaping (ImageLoaderResult) -> Void) {
        
        let result = Reachability.isConnectedToNetwork() ? remoteImageLoader.loadImage : localImageLoader.loadImage
        result(completion)
    }
}
