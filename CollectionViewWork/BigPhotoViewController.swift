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
    
    func getPhoto(at indexPath: IndexPath) -> PhotoModel
    func scrollToItem()
}

class BigPhotoViewController: UIViewController {
    var presenter: BigPhotoViewOutputProtocol!
    
    private var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        presenter.scrollToItem()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 2.5, bottom: 10, right: 2.5)
        layout.minimumLineSpacing = 5
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

extension BigPhotoViewController: BigPhotoViewInputProtocol {
    func scrollToItem(at indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}

extension BigPhotoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.photosCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as! CollectionViewCell
        cell.configure(with: presenter.getPhoto(at: indexPath))
        
        return cell
    }
}

extension BigPhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 5, height: UIScreen.main.bounds.height)
    }
}
