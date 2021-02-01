//
//  BigPhotoInteracter.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 01.02.2021.
//

import Foundation

protocol BigPhotoInteractorInputProtocol: class {
    init(presenter: BigPhotoInteractorOutputProtocol )
}

protocol BigPhotoInteractorOutputProtocol: class {
    
}

class BigPhotoInteractor: BigPhotoInteractorInputProtocol {
    unowned let presenter: BigPhotoInteractorOutputProtocol
    
    required init(presenter: BigPhotoInteractorOutputProtocol) {
        self.presenter = presenter
    }
}
