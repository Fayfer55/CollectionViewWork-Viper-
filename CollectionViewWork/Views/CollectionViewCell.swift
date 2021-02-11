//
//  CollectionViewCell.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 28.01.2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let reuseId = "CollectionViewCell"
    
    private let checkmark = UIImageView(image: UIImage(systemName: "checkmark.circle.fill"))
    
//    private lazy var view: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        layer.opacity = 0.5
//        return view
//    }()
    
//    override var isHighlighted: Bool {
//        didSet {
//            view.isHidden = !isHighlighted
//        }
//    }
    
    override var isSelected: Bool {
        didSet {
//            view.isHidden = !isSelected
            checkmark.isHidden = !isSelected

        }
    }
    
    private lazy var mainImage: ImageView = {
        let imageView = ImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        checkmark.isHidden = true
        
        imageView.addSubview(checkmark)
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(mainImage)
        
        mainImage.translatesAutoresizingMaskIntoConstraints = false
        mainImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with urlResult: String) {
        mainImage.fetchImage(from: urlResult)
    }
}

