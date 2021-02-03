//
//  PhotosPresenter.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 29.01.2021.
//

import Foundation

class PhotosPresenter: PhotosViewOutputProtocol {
    unowned var view: PhotosViewInputProtocol
    var interactor: PhotosInteractorInputProtocol!
    var router: PhotosRouterInputProtocol!
    var photosCount: Int {
        photos.count
    }
    private var page = 1
    private var photos = [PhotoModel]()
    private var selectedPhotos = [String]()
    private var searchText: String?
    
    required init(view: PhotosViewInputProtocol) {
        self.view = view
    }
    
    func getPhoto(at indexPath: IndexPath) -> String {
        photos[indexPath.item].urls.small
    }
    
    func showPhotos(with searchText: String?) {
        view.startAnimationActivityIndicator()
        interactor.fetchPhotos(with: searchText ?? "", and: page)
        self.searchText = searchText
    }
    
    func showNewPagePhotos() {
        page += 1
        interactor.fetchPhotos(with: searchText ?? "", and: page)
    }
    
    func showBigPhoto(at indexPath: IndexPath) {
        router.openBigPhotoViewController(with: photos, and: indexPath)
    }
    
    func collectionItemPressed(at indexPath: IndexPath) {
        let photo = photos[indexPath.item].urls.regular
        
        if !selectedPhotos.contains(photo) {
            selectedPhotos.append(photo)
            view.itemPressed(at: indexPath, and: 0.7)
        } else {
            selectedPhotos.remove(at: selectedPhotos.firstIndex(of: photo) ?? 0)
            view.itemPressed(at: indexPath, and: 0.0)
        }
    }
}

extension PhotosPresenter: PhotosInteractorOutputProtocol {
    func photosDidRecieve(_ photos: [PhotoModel]) {
        self.photos.append(contentsOf: photos)
        view.stopAnimationActivityIndicator()
        view.reloadData()
    }
}
