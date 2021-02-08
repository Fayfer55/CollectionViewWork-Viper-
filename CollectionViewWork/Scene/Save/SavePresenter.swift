//
//  SavePresenter.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 04.02.2021.
//

import Foundation

class SavePresenter: SaveViewOutputProtocol {
    var savedPhotos = [String]()
    var deleteIndeces = [IndexPath]()
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
    
    func selectElements(at indexPath: IndexPath) {
        if !deleteIndeces.contains(indexPath) {
            deleteIndeces.append(indexPath)
        } else {
            deleteIndeces.remove(at: indexPath.item)
        }
    }
    
    func deleteElements() {
        AlertManager.shared.showActionAlert(
            title: "Are you sure?",
            message: "You can't recover photos") { [weak self] in
            for index in self!.deleteIndeces {
                self?.savedPhotos.remove(at: index.item)
            }
            self?.view.deleteItem(at: self?.deleteIndeces ?? [IndexPath()])
            self?.interactor.deletePhotos(at: self?.deleteIndeces ?? [IndexPath()])
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
