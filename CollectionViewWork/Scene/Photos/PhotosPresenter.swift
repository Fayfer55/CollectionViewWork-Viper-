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
    private var dictionaryIndeces = [IndexPath:Bool]()
    private var selectedIndeces = [IndexPath]()
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
    
    func showSavedPhotos() {
        router.openSaveViewController()
    }
    
    func selectItem(at indexPath: IndexPath) {
        dictionaryIndeces[indexPath] = true
    }
    
    func deselectItem(at indexPath: IndexPath) {
        dictionaryIndeces[indexPath] = false
    }
    
    func selectionAllowed() {
        view.selectionAllowed()
    }
    
    func selectionBanned() {
        view.selectionBanned(with: dictionaryIndeces)
        selectedIndeces.removeAll()
    }
    
    func savePhotos() {
        for (key,value) in dictionaryIndeces {
            if value == true {
                selectedIndeces.append(key)
            }
        }
        for index in selectedIndeces.sorted(by: { $0.item > $1.item }) {
            let photo = photos[index.item].urls.small
            selectedPhotos.append(photo)
            view.deselectItem(at: index)
        }
        interactor.savePhotos(photos: selectedPhotos)
        selectedIndeces.removeAll()
        selectedPhotos.removeAll()
        dictionaryIndeces.removeAll()
        AlertManager.shared.showsimpleAlert(
            title: "Your photos where saved",
            message: "You can find them in gallery in up left corner") { [weak self] (alert) in
            self?.view.showAlert(with: alert)
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
