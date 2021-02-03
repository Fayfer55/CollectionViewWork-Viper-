//
//  PhotosViewController.swift
//  CollectionViewWork
//
//  Created by Кирилл Файфер on 28.01.2021.
//

import UIKit

protocol PhotosViewInputProtocol: class {
    func reloadData()
    func startAnimationActivityIndicator()
    func stopAnimationActivityIndicator()
    func itemPressed(at indexPath: IndexPath, and alpha: CGFloat)
}

protocol PhotosViewOutputProtocol: class {
    var photosCount: Int { get }
    
    init(view: PhotosViewInputProtocol)
    func showPhotos(with searchText: String?)
    func getPhoto(at indexPath: IndexPath) -> String
    func showNewPagePhotos()
    func showBigPhoto(at indexPath: IndexPath)
    func collectionItemPressed(at indexPath: IndexPath)
}


class PhotosViewController: UIViewController {
    var presenter: PhotosViewOutputProtocol!
    // MARK: Private properties
    private var collectionView: UICollectionView!
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private lazy var activityView = UIActivityIndicatorView(style: .large)
    
    private let configarator: PhotosConfiguratorProtocol = PhotosConfigurator()
    
    // MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configarator.configure(with: self)
        
        setupNavigationBar()
        setupCollectionView()
        setupSearchController()
        showActivityIndicator()
    }
    
    override func updateViewConstraints() {
        activityView.center = view.center
        
        super.updateViewConstraints()
    }
}

// MARK: UICollectionViewDataSource
extension PhotosViewController: UICollectionViewDataSource {
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
extension PhotosViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.itemWidth, height: Constants.itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == presenter.photosCount - 4 {
            presenter.showNewPagePhotos()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing {
            presenter.collectionItemPressed(at: indexPath)
        } else {
            presenter.showBigPhoto(at: indexPath)
        }
    }
}

// MARK: SearchButton
extension PhotosViewController:  UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.showPhotos(with: searchBar.text)
    }
}

// MARK: Setup UI
extension PhotosViewController {
    private func setupNavigationBar() {
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        navigationItem.title = "Photos"
        navigationItem.leftBarButtonItem = editButtonItem
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
    
    private func setupSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.delegate = self
        searchController.searchBar.showsCancelButton = true
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func showActivityIndicator() {
        view.addSubview(activityView)
        
        activityView.hidesWhenStopped = true
    }
}

extension PhotosViewController: PhotosViewInputProtocol {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func startAnimationActivityIndicator() {
        activityView.startAnimating()
    }
    
    func stopAnimationActivityIndicator() {
        activityView.stopAnimating()
    }
    
    func itemPressed(at indexPath: IndexPath, and alpha: CGFloat) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        cell.layer.borderWidth = 200.0
        cell.layer.borderColor = UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: alpha).cgColor
        cell.isClicked.toggle()
    }
}
