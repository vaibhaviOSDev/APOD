//
//  ImageDataMapper.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

internal final class ImageDataMapper {
 
    struct ImageDetails: Decodable {
        
        private let title: String
        private let date: String
        private let url: URL
        private let explanation: String
        
        enum CodingKeys: String, CodingKey {
            case title
            case date
            case url
            case explanation
        }
        var image: Image {
            return Image(title: title, date: date, imageURL: url, description: explanation)
        }
    }
    private static var status_OK: Int {
        return 200
    }
    internal static func map(_ data: Data, _ response: HTTPURLResponse) -> RemoteImageLoader.Result {
        guard response.statusCode == ImageDataMapper.status_OK,
           let imageDetail = try? JSONDecoder().decode(ImageDetails.self, from: data) else {
               return .failure(RemoteImageLoader.Error.invalidData)
         }
        return .success(imageDetail.image)
    }
}
