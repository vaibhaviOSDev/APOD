//
//  APODFactory.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 10.2.2022.
//

import Foundation

public final class APODFactory {
    
    public static func getRemoteWithLocalFallbackImageLoader(url: URL) -> RemoteWithLocalFallBackImageLoader {
        let remoteImageLoader = RemoteImageLoader(url: url)
        let localImageLoader = LocalImageLoader()
        let remoteWithLocalFallBackImageLoader = RemoteWithLocalFallBackImageLoader(
            remoteImageLoader: remoteImageLoader,
            localImageLoader: localImageLoader)
        
        return remoteWithLocalFallBackImageLoader
    }
}
