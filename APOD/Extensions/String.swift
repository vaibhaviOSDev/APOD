//
//  String+Extension.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

extension String {
    
    public func isImage() -> Bool {
        let imageFormats = ["jpg", "png", "gif"]
        guard URL(string: self) != nil  else {
            return false
        }
        let imageExtension = (self as NSString).pathExtension
        return imageFormats.contains(imageExtension)
    }
}
