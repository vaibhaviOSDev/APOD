//
//  HTTPClient.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}
public enum HTTPClientFetchImageResult {
    case success(URL)
    case failure(Error)
}
// MARK: - HTTPClient

/// Can be confirmed by any API to fetch the Images details
public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
    func fetchImageFromServer(from url: URL, completion: @escaping (HTTPClientFetchImageResult) -> Void)
}
