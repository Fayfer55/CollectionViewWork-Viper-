//
//  StorageManager.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 04.02.2021.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let photosKey = "photos"
    
    private init() {}
    
    func load() -> [String] {
        if let photos = userDefaults.value(forKey: photosKey) as? [String] {
            return photos
        }
        return []
    }
    
    func save(value: [String]) {
        var photos = load()
        photos.append(contentsOf: value)
        userDefaults.set(photos, forKey: photosKey)
    }
    
    func delete(value: Int) {
        var photos = load()

        photos.remove(at: value)
        
        userDefaults.set(photos, forKey: photosKey)
    }
}
