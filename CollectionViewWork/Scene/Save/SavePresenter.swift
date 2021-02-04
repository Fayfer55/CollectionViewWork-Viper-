//
//  SavePresenter.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 04.02.2021.
//

import Foundation

class SavePresenter: SaveViewOutputProtocol {
    var savedPhotos = [String]()
    var photosCount: Int {
        savedPhotos.count
    }
    
    unowned var view: SaveViewInputProtocol
    var interactor: SaveInteractorInputProtocol!
    
    required init(view: SaveViewInputProtocol) {
        self.view = view
    }
    
    func getPhoto(at indexPath: IndexPath) -> String {
        savedPhotos[indexPath.item]
    }
    
    func fetchPhotos() {
        interactor.fetchPhotos()
    }
    
    func selectionAllowed() {
        view.selectionAllowed()
    }
    
    func selectionBanned() {
        view.selectionBanned()
    }
}

extension SavePresenter: SaveInteractorOutputProtocol {
    func photosDidRecieve(_ photos: [String]) {
        savedPhotos = photos
    }
}
