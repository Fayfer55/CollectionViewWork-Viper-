//
//  ImageView.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 28.01.2021.
//

import UIKit

class ImageView: UIImageView {
    func fetchImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        ImageManager.shared.download(with: imageURL) { [weak self] (image, url) in
            if imageURL == url {
                self?.image = image
            }
        }
    }
}
