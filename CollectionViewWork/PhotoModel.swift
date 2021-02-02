//
//  PhotoModel.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 28.01.2021.
//

import Foundation

struct PhotoModel: Decodable {
    let urls: Urls
}

struct Urls: Decodable {
    let small: String
    let regular: String
}
