//
//  PhotosInteractor.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 29.01.2021.
//

import Foundation

protocol PhotosInteractorInputProtocol: class {
    init(presenter: PhotosInteractorOutputProtocol )
    func fetchPhotos(with query: String, and page: Int)
    func savePhotos(photos: [PhotoModel])
}

protocol PhotosInteractorOutputProtocol: class {
    func photosDidRecieve(_ photos: [PhotoModel])
}

class PhotosInteractor: PhotosInteractorInputProtocol {
    unowned let presenter: PhotosInteractorOutputProtocol
    
    required init(presenter: PhotosInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchPhotos(with query: String, and page: Int) {
        let url = Constants.urlWithKey + query
        NetworkManager.shared.network(url: url, page: page) { [weak self] (photos) in
            self?.presenter.photosDidRecieve(photos)
        }
    }
    
    func savePhotos(photos: [PhotoModel]) {
        StorageManager.shared.save(value: photos)
    }
}
