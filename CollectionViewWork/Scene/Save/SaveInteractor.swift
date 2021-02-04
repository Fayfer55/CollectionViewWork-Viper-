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
}

protocol  SaveInteractorOutputProtocol: class {
    func photosDidRecieve(_ photos: [String])
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
}
