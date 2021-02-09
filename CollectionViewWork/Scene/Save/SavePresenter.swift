//
//  SavePresenter.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 04.02.2021.
//

import Foundation

class SavePresenter: SaveViewOutputProtocol {
    var savedPhotos = [String]()
    var deleteIndeces = [IndexPath: Bool]()
    var deleteNeed = [IndexPath]()
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
            title: "Are you sure?",
            message: "You can't recover photos") { [weak self] in
            for (key,value) in self!.deleteIndeces {
                if value == true {
                    self?.deleteNeed.append(key)
                }
            }
            for index in self!.deleteNeed.sorted(by: { $0.item > $1.item }) {
                self?.savedPhotos.remove(at: index.item)
            }
            self?.view.deleteItem(at: self?.deleteNeed ?? [])
            self?.interactor.deletePhotos(at: self?.deleteNeed ?? [])
            self?.deleteNeed.removeAll()
        } complitionForPresenting: { [weak self] (alert) in
            self?.view.showAlert(with: alert)
        }
    }
}


extension SavePresenter: SaveInteractorOutputProtocol {
    func photosDidRecieve(_ photos: [String]) {
        savedPhotos = photos
    }
}
