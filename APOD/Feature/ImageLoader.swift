//
//  ImageLoader.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

public enum ImageLoaderResult {
    case success(Image)
    case failure(Error)
}
public protocol ImageLoader {
    func load(completion: @escaping (ImageLoaderResult) -> Void)
}
