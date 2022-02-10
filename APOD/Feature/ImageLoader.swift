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
public protocol ImageLoader {
    func loadImage(completion: @escaping (ImageLoaderResult) -> Void)
}
