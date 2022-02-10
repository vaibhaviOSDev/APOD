//
//  ImageDataMapper.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

internal final class ImageDataMapper {
 
    struct ImageDetails: Decodable {
        
         let title: String
         let date: String
         let url: URL
         let explanation: String
        
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
    static var imageURL: URL?
    
    internal static func map(_ data: Data, _ response: HTTPURLResponse) -> ImageDetailsLoaderResult {
        guard response.statusCode == ImageDataMapper.status_OK,
           let imageDetail = try? JSONDecoder().decode(ImageDetails.self, from: data) else {
               return .failure(RemoteImageLoader.Error.invalidData)
         }
        ImageDataMapper.imageURL = imageDetail.image.imageURL
        
        let imageViewModel = ImageViewModel(
            imageInfo: Image(
                title: imageDetail.title,
                date: imageDetail.date,
                imageURL: imageDetail.url,
                description: imageDetail.explanation),
            isFavourite: false,
            imageData: nil)
        
        return .success(imageViewModel)
    }
    internal static func mapImageLocalURL(localURL: URL) -> Data? {

        guard let imageData = try? Data(contentsOf: localURL) else {
            return nil
        }
        return imageData
    }
}
