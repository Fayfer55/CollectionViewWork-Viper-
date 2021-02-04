//
//  SaveConfigurator.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 04.02.2021.
//

import Foundation

protocol SaveConfiguratorInputProtocol: class {
    func configure(with viewController: SaveViewController)
}

class SaveConfigurator: SaveConfiguratorInputProtocol {
    func configure(with viewController: SaveViewController) {
        let presenter = SavePresenter(view: viewController)
        let interacter = SaveInteractor(presenter: presenter)
        
        viewController.presenter = presenter
        presenter.interactor = interacter
    }
}
