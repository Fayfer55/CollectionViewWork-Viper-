//
//  SavePresenter.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 04.02.2021.
//

import Foundation

class SavePresenter: SaveViewOutputProtocol {
    var savedPhotos = [PhotoModel]()
    var deleteIndeces = [IndexPath: Bool]()
    var deleteNeed = [IndexPath]()
    var photosCount: Int {
        savedPhotos.count
    }
    
    unowned var view: SaveViewInputProtocol
    var interactor: SaveInteractorInputProtocol!
    var router: SaveRouterInputProtocol!
    
    required init(view: SaveViewInputProtocol) {
        self.view = view
    }
    
    func getPhoto(at indexPath: IndexPath) -> String {
        savedPhotos[indexPath.item].urls.small
    }
    
    func fetchPhotos() {
        interactor.fetchPhotos()
    }
    
    func selectionAllowed() {
        view.selectionAllowed()
    }
    
    func selectionBanned() {
        view.selectionBanned(with: deleteIndeces)
    }
    
    func selectElements(at indexPath: IndexPath) {
        deleteIndeces[indexPath] = true
        }

    func deselectItems(at indexPath: IndexPath) {
        deleteIndeces[indexPath] = false
    }
    
    func deleteElements() {
        AlertManager.shared.showActionAlert(
            title: "Are you sure? You can't recover photos",
            message: "") { [weak self] in
            for (key,value) in self!.deleteIndeces {
                if value == true {
                    self?.deleteNeed.append(key)
                }
            }
            self?.deleteNeed = self?.deleteNeed.sorted(by: { $0.item > $1.item }) ?? []
            for index in self!.deleteNeed {
                self?.savedPhotos.remove(at: index.item)
            }
            self?.view.deleteItem(at: self?.deleteNeed ?? [])
            self?.interactor.deletePhotos(at: self?.deleteNeed ?? [])
            self?.deleteNeed.removeAll()
            self?.deleteIndeces.removeAll()
        } complitionForPresenting: { [weak self] (alert) in
            self?.view.showAlert(with: alert)
        }
    }
    
    func showBigPhoto(at indexPath: IndexPath) {
        router.openBigPhotoViewController(with: savedPhotos, and: indexPath)
    }
}


extension SavePresenter: SaveInteractorOutputProtocol {
    func photosDidRecieve(_ photos: [PhotoModel]) {
        savedPhotos = photos
    }
}
