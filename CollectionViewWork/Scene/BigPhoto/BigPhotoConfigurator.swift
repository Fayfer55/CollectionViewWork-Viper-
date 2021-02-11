//
//  BigPhotoConfigurator.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 01.02.2021.
//

import Foundation

protocol BigPhotoConfiguratorProtocol: class {
    func  configure(with viewController: BigPhotoViewController, and photos: [PhotoModel], indexPath: IndexPath)
}

class BigPhotoConfigurator: BigPhotoConfiguratorProtocol {
    func configure(with viewController: BigPhotoViewController, and photos: [PhotoModel], indexPath: IndexPath) {
        let presenter = BigPhotoPresenter(view: viewController, photos: photos, indexPath: indexPath)
        let interacter = BigPhotoInteractor(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interacter
    }
}
