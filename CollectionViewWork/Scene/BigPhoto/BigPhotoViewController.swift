//
//  BigPhotoViewController.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 01.02.2021.
//

import UIKit

protocol BigPhotoViewInputProtocol: class {
    func scrollToItem(at indexPath: IndexPath)
}

protocol BigPhotoViewOutputProtocol: class {
    var photosCount: Int { get }
    init(view: BigPhotoViewInputProtocol, photos: [PhotoModel], indexPath: IndexPath)
    
    func getPhoto(at indexPath: IndexPath) -> String
    func scrollToItem()
//    func deleteButtonPressed()
}

class BigPhotoViewController: UIViewController {
    var presenter: BigPhotoViewOutputProtocol!
    
    private var collectionView: UICollectionView!
    
//    private lazy var deleteButton: UIButton = {
//        let deleteButton = UIButton(type: .system)
//        deleteButton.translatesAutoresizingMaskIntoConstraints = false
//        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
//        deleteButton.addTarget(self, action: #selector(deleteButtonPressed), for: .allEvents)
//        return deleteButton
//    }()
    
    // MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        presenter.scrollToItem()
//        view.addSubview(deleteButton)
    }
    
//    override func updateViewConstraints() {
//        deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
//            .isActive = true
//        deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
//            .isActive = true
//
//        super.updateViewConstraints()
//    }
    
    // MARK: Private methods
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: -10, left: 2.5, bottom: 30, right: 2.5)
        layout.minimumLineSpacing = Constants.minimumLineSpacingHorizontal
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = true
        
        view.addSubview(collectionView)
    }
}

// Mark: UICollectionViewDataSource, UICollectionViewDelegate
extension BigPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.photosCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as! CollectionViewCell
        
            cell.configure(with: presenter.getPhoto(at: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// Mark: UICollectionViewDelegateFlowLayout
extension BigPhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 5, height: UIScreen.main.bounds.height - 150)
    }
}

extension BigPhotoViewController: BigPhotoViewInputProtocol {
    func scrollToItem(at indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}

//extension BigPhotoViewController {
//    @objc private func deleteButtonPressed() {
//
//    }
//}
