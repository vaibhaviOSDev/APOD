//
//  LocalImageLoader.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

public final class LocalImageLoader {
    
}
extension LocalImageLoader: ImageDetailsLoader {
    public func load(completion: @escaping (ImageDetailsLoaderResult) -> Void) {
        
    }
}
extension LocalImageLoader: ImageLoader {
    public func loadImage(completion: @escaping (ImageLoaderResult) -> Void) {
        
    }
}
