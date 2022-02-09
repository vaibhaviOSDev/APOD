//
//  RemoteImageLoader.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

public final class RemoteImageLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    public typealias Result = ImageLoaderResult

    init(url: URL, client: HTTPClient = URLSession.shared) {
        self.url = url
        self.client = client
    }
}
extension RemoteImageLoader: ImageLoader {
    
    public func load(completion: @escaping (Result) -> Void) {
        
        client.get(from: url) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case let .success(data, response):
                completion(ImageDataMapper.map(data, response))
            case .failure :
                completion(.failure(Error.connectivity))
            }
        }
    }

}

