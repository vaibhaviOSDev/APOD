//
//  RemoteWithLocalFallBackImageLoader.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

class RemoteWithLocalFallBackImageLoader {
    public typealias Result = ImageLoaderResult

    private let remoteImageLoader: RemoteImageLoader
    private let localImageLoader: LocalImageLoader
    
    init(remoteImageLoader: RemoteImageLoader, localImageLoader: LocalImageLoader) {
        self.remoteImageLoader = remoteImageLoader
        self.localImageLoader = localImageLoader
    }
}
extension RemoteWithLocalFallBackImageLoader: ImageLoader {
    
    public func load(completion: @escaping (Result) -> Void) {
        
        let result = Reachability.isConnectedToNetwork() ? remoteImageLoader.load : localImageLoader.load
        result(completion)
    }
}
