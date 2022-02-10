//
//  ImageLoader.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

public enum ImageDetailsLoaderResult {
    case success(Image)
    case failure(Error)
}
public protocol ImageDetailsLoader {
    func load(completion: @escaping (ImageDetailsLoaderResult) -> Void)
}
