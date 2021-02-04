//
//  SaveViewController.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 04.02.2021.
//

import UIKit

protocol SaveViewInputProtocol: class {
    func selectionBanned()
    func selectionAllowed()
}

protocol SaveViewOutputProtocol: class {
    var photosCount: Int { get }
    init(view: SaveViewInputProtocol)
    
    func getPhoto(at indexPath: IndexPath) -> String
    func fetchPhotos()
    func selectionBanned()
    func selectionAllowed()
}

class SaveViewController: UIViewController {
    var presenter: SaveViewOutputProtocol!
    // MARK: Private properties
    private var collectionView: UICollectionView!
    
    private lazy var selectBarButtonItem: UIBarButtonItem = {
        let selectBarButtonItem = UIBarButtonItem(
            title: "Select",
            style: .plain,
            target: self,
            action: #selector(selectButtonPressed)
        )
        return selectBarButtonItem
    }()
    
    private lazy var deleteBarButtonItem: UIBarButtonItem = {
        let selectBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash,
            target: self,
            action: nil
        )
        return selectBarButtonItem
    }()
    
    private var isSelected = false {
        didSet {
            switch isSelected {
            case false:
                presenter.selectionBanned()
            case true:
                presenter.selectionAllowed()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupCollectionView()
        presenter.fetchPhotos()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        layout.minimumInteritemSpacing = Constants.minimumItemSpacing
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reuseId)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
    }
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        navigationItem.title = "Collection"
        navigationItem.rightBarButtonItem = selectBarButtonItem
    }
}

// MARK: UICollectionViewDataSource
extension SaveViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.photosCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId, for: indexPath) as! CollectionViewCell
        cell.configure(with: presenter.getPhoto(at: indexPath))
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate
extension SaveViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.itemWidth, height: Constants.itemWidth)
    }
}

extension SaveViewController: SaveViewInputProtocol {
    func selectionAllowed() {
        selectBarButtonItem.title = "Done"
        navigationItem.leftBarButtonItem = deleteBarButtonItem
        collectionView.allowsMultipleSelection = true
    }
    
    func selectionBanned() {
        selectBarButtonItem.title = "Select"
        navigationItem.leftBarButtonItem = nil
        collectionView.allowsMultipleSelection = false
    }
}

extension SaveViewController {
    @objc private func selectButtonPressed() {
        isSelected = isSelected == false ? true : false
    }
}
