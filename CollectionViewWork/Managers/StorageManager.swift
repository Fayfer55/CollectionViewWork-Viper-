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
    private let photosKey = "newPhotos"
    
    private init() {}
    
    func load() -> [PhotoModel] {
        if let data = userDefaults.value(forKey: photosKey) as? Data {
            guard let photos = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [PhotoModel] else { return []}
            return photos
        }
        return []
    }
    
    func save(value: [PhotoModel]) {
        var photos = load()
        photos.append(contentsOf: value)
        
        let data = archieveData(with: value)
        
        userDefaults.set(data, forKey: photosKey)
    }
    
    func delete(value: Int) {
        var photos = load()

        photos.remove(at: value)
        
        save(value: photos)
    }
    
    private func archieveData(with photos:[PhotoModel]) -> Data? {
        let archieveData = try? NSKeyedArchiver.archivedData(withRootObject: photos, requiringSecureCoding: false)
        return archieveData
    }
}
