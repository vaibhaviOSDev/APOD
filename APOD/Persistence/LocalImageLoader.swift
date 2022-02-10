//
//  LocalImageLoader.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

public final class LocalImageLoader {
    
    public typealias Result = ImageLoaderResult

}
extension LocalImageLoader: ImageLoader {
    
    public func load(completion: @escaping (Result) -> Void) {
        
    }
}
