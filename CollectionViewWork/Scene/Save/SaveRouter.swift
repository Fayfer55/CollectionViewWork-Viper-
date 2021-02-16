//
//  SaveRouter.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 16.02.2021.
//

import Foundation

protocol SaveRouterInputProtocol: class {
    init(viewController: SaveViewController)
    func openBigPhotoViewController(with photos: [PhotoModel], and indexPath: IndexPath)
}

class SaveRouter: SaveRouterInputProtocol {
    unowned let viewController: SaveViewController
    
    required init(viewController: SaveViewController) {
        self.viewController = viewController
    }
    
    func openBigPhotoViewController(with photos: [PhotoModel], and indexPath: IndexPath) {
        let bigPhotoViewController = BigPhotoViewController()
        let configurator: BigPhotoConfigurator = BigPhotoConfigurator()
        
        configurator.configure(with: bigPhotoViewController, and: photos, indexPath: indexPath)
        
        viewController.navigationController?.pushViewController(bigPhotoViewController, animated: true)
    }
}
