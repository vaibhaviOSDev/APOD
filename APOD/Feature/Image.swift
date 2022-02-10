//
//  ImageModel.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 9.2.2022.
//

import Foundation

// MARK: - Image Model

/// Independent of all modules
public struct Image {
    let title: String
    let date: String
    let imageURL: URL?
    let description: String
}
