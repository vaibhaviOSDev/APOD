//
//  ImageLoader.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

public enum ImageDetailsLoaderResult {
    case success(ImageViewModel)
    case failure(Error)
}
// MARK: - ImageDetailsLoader

/// Agnostic of Network/Persistence layer & can be confirmed by either API module or by Persistence Module
/// Returns the Image details
public protocol ImageDetailsLoader {
    func load(completion: @escaping (ImageDetailsLoaderResult) -> Void)
}
