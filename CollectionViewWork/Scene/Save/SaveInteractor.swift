//
//  SaveInteractor.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 04.02.2021.
//

import Foundation

protocol SaveInteractorInputProtocol: class {
    init(presenter: SaveInteractorOutputProtocol)
    
    func fetchPhotos()
    func deletePhotos(at indexPaths: [IndexPath])
}

protocol  SaveInteractorOutputProtocol: class {
    func photosDidRecieve(_ photos: [PhotoModel])
}

class SaveInteractor: SaveInteractorInputProtocol {
    unowned let presenter: SaveInteractorOutputProtocol
    
    required init(presenter: SaveInteractorOutputProtocol) {
        self.presenter = presenter
    }
    
    func fetchPhotos() {
        let photos = StorageManager.shared.load()
        
        presenter.photosDidRecieve(photos)
    }
    
    func deletePhotos(at indexPaths: [IndexPath]) {
        let values = indexPaths
        
        for index in values {
            StorageManager.shared.delete(value: index.item)
        }
    }
}
