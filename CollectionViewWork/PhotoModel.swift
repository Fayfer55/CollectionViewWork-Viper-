//
//  PhotoModel.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 28.01.2021.
//

import Foundation

class PhotoModel: NSObject, Decodable, NSCoding {
    let urls: Urls
    
    init (urls: Urls) {
        self.urls = urls
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(urls.small, forKey: "small")
        coder.encode(urls.regular, forKey: "regular")
    }
    
    required init?(coder: NSCoder) {
        urls = Urls(
            small: coder.decodeObject(forKey: "small") as? String ?? "",
            regular: coder.decodeObject(forKey: "regular") as? String ?? ""
        )
    }
    
    
}

struct Urls: Decodable {
    let small: String
    let regular: String
}
