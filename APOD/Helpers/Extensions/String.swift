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

        if URL(string: self) != nil  {

            let extensi = (self as NSString).pathExtension

            return imageFormats.contains(extensi)
        }
        return false
    }
}
