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
    func selectionAllowed()
    func selectionBanned(with dictionaryIndeces: [IndexPath:Bool])
    func showAlert(with alert: UIAlertController)
    func deselectItem(at indexPath: IndexPath)
}

protocol PhotosViewOutputProtocol: class {
    var photosCount: Int { get }
    
    init(view: PhotosViewInputProtocol)
    func showPhotos(with searchText: String?)
    func getPhoto(at indexPath: IndexPath) -> String
    func showNewPagePhotos()
    func showBigPhoto(at indexPath: IndexPath)
    func selectItem(at indexPath: IndexPath)
    func deselectItem(at indexPath: IndexPath)
    func selectionAllowed()
    func selectionBanned()
    func showSavedPhotos()
    func savePhotos()
}

class PhotosViewController: UIViewController {
    var presenter: PhotosViewOutputProtocol!
    // MARK: Private properties
    private var collectionView: UICollectionView!
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    private lazy var activityView = UIActivityIndicatorView(style: .large)
    
    private let configurator: PhotosConfiguratorProtocol = PhotosConfigurator()
    
    private var mode: Mode = .view {
        didSet {
            switch mode {
            case .view:
                presenter.selectionBanned()
            case .select:
                presenter.selectionAllowed()
            }
        }
    }
    
    private lazy var selectBarButtonItem: UIBarButtonItem = {
        let selectBarButtonItem = UIBarButtonItem(
            title: "Select",
            style: .plain,
            target: self,
            action: #selector(selectButtonPressed)
        )
        return selectBarButtonItem
    }()
        
    private lazy var saveBarButtonItem: UIBarButtonItem = {
        let saveBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonPressed)
        )
        return saveBarButtonItem
    }()
    
    private lazy var collectionBarButtonItem: UIBarButtonItem = {
        let collectionBarButton = UIBarButtonItem(
            image: UIImage(systemName: "photo.fill.on.rectangle.fill"),
            style: .plain,
            target: self,
            action: #selector(collectionButtonPressed)
        )
        return collectionBarButton
    }()
    
    // MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(with: self)
        
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
        switch mode {
        case .select:
            presenter.selectItem(at: indexPath)
        case .view:            
            collectionView.deselectItem(at: indexPath, animated: true)
            presenter.showBigPhoto(at: indexPath)
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if mode == .select {
            presenter.deselectItem(at: indexPath)
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
        navigationItem.rightBarButtonItem = selectBarButtonItem
        navigationItem.leftBarButtonItem = collectionBarButtonItem
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
    
    func selectionAllowed() {
        selectBarButtonItem.title = "Done"
        navigationItem.leftBarButtonItem = saveBarButtonItem
        collectionView.allowsMultipleSelection = true
    }
    
    func selectionBanned(with dictionaryIndeces: [IndexPath:Bool]) {
        for (key,value) in dictionaryIndeces {
            if value {
                collectionView.deselectItem(at: key, animated: true)
            }
        }
        selectBarButtonItem.title = "Select"
        navigationItem.leftBarButtonItem = collectionBarButtonItem
        collectionView.allowsMultipleSelection = false
    }
    
    func showAlert(with alert: UIAlertController) {
        present(alert, animated: true)
    }
    
    func deselectItem(at indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

// MARK: OBJC Methods
extension PhotosViewController {
    @objc private func selectButtonPressed() {
        mode = mode == .view ? .select : .view
    }
    
    @objc private func saveButtonPressed() {
        presenter.savePhotos()
    }
    
    @objc private func collectionButtonPressed() {
        presenter.showSavedPhotos()
    }
}
