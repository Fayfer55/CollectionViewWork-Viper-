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
    
    var isClicked = false {
        didSet {
            isSelected = true
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isClicked {
                checkmark.isHidden = !isSelected
            }
        }
    }
    
    private lazy var mainImage: ImageView = {
        let imageView = ImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
//        highLightIndicator.isHidden = true
        checkmark.isHidden = true
        
//        imageView.addSubview(highLightIndicator)
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

