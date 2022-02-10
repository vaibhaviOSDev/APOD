//
//  URLSession+HTTPClient.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 10.2.2022.
//

import Foundation

// MARK: URLSession
/// URLSession extends the HTTPClient protocol to perform the Network operations

extension URLSession: HTTPClient {
    
    /// Data task for fetching Image details
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void ) {
            
        dataTask(with: url) { data, response, error in
            if let data = data,
               let response = response as? HTTPURLResponse {
                completion(.success(data, response))
            } else {
                if let error = error {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    /// Download task for fetching Image
    public func fetchImageFromServer(from url: URL, completion: @escaping (HTTPClientFetchImageResult) -> Void) {
        
        downloadTask(with: url) { localURL, response, error in
            if let localURL = localURL {
                completion(.success(localURL))
            } else {
               if let error = error {
                completion(.failure(error))
               }
            }
        }.resume()
    }
}
