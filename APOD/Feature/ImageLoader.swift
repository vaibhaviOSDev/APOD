//
//  ImageLoader.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 10.2.2022.
//

import Foundation

public enum ImageLoaderResult {
    case success(Data)
    case failure(Error)
}
// MARK: - ImageLoader

/// Agnostic of Network/Persistence layer & can be confirmed by either API module or by Persistence Module
/// Returns the Image downloaded from network or stored locally
public protocol ImageLoader {
    func loadImage(completion: @escaping (ImageLoaderResult) -> Void)
}
