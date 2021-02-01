//
//  BigPhotoPresenter.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 01.02.2021.
//

import Foundation

class BigPhotoPresenter: BigPhotoViewOutputProtocol {
    unowned var view: BigPhotoViewInputProtocol
    var interactor: BigPhotoInteractorInputProtocol!
    var photos: [PhotoModel]
    var indexPath: IndexPath
    
    var photosCount: Int {
        photos.count
    }
    
    required init(view: BigPhotoViewInputProtocol, photos: [PhotoModel], indexPath: IndexPath) {
        self.view = view
        self.photos = photos
        self.indexPath = indexPath
    }
    
    func getPhoto(at indexPath: IndexPath) -> PhotoModel {
        photos[indexPath.item]
    }
    
    func scrollToItem() {
        view.scrollToItem(at: indexPath)
    }
}

extension BigPhotoPresenter: BigPhotoInteractorOutputProtocol {
    
}
