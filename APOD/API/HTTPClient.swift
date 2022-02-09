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

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void )
}

extension URLSession: HTTPClient {
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
}
