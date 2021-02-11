//
//  PhotosRouter.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 29.01.2021.
//

import Foundation

protocol PhotosRouterInputProtocol: class {
    init(viewController: PhotosViewController)
    func openBigPhotoViewController(with photos: [PhotoModel], and indexPath: IndexPath)
    func openSaveViewController()
}

protocol PhotosConfiguratorProtocol: class {
    func  configure(with viewController: PhotosViewController)
}

class PhotosRouter: PhotosRouterInputProtocol {
    unowned let viewController: PhotosViewController
    
    required init(viewController: PhotosViewController) {
        self.viewController = viewController
    }
    
    func openBigPhotoViewController(with photos: [PhotoModel], and indexPath: IndexPath) {
        let bigPhotoViewController = BigPhotoViewController()
        let configurator: BigPhotoConfigurator = BigPhotoConfigurator()
        
        configurator.configure(with: bigPhotoViewController, and: photos, indexPath: indexPath)
        
        viewController.navigationController?.pushViewController(bigPhotoViewController, animated: true)
    }
    
    func openSaveViewController() {
        let saveViewController = SaveViewController()
        let coordinator: SaveConfigurator = SaveConfigurator()
        
        coordinator.configure(with: saveViewController)
        
        viewController.navigationController?.pushViewController(saveViewController, animated: true)
    }
}

class PhotosConfigurator: PhotosConfiguratorProtocol {
    func configure(with viewController: PhotosViewController) {
        let presenter = PhotosPresenter(view: viewController)
        let interacter = PhotosInteractor(presenter: presenter)
        let router = PhotosRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interacter
        presenter.router = router
    }
}
