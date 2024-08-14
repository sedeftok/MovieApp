//
//  FavoritesVC.swift
//  tmdbMovie
//
//  Created by sedef tok on 14.08.2024.
//

import UIKit

class FavoritesVC: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView( frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: FavoritesCollectionViewCell.identifier)
        return collectionView
    }()

    var favMovieList: [FavoriteMovie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Favorites"
        
        initDelegate()
    }
    
    private func initDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        
        favCollectionView()
    }
    
    private func favCollectionView() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view)
        }
    }
}

extension FavoritesVC:  UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.identifier, for: indexPath) as? FavoritesCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let movie = favMovieList[indexPath.row]
        cell.setup(with: movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let width = UIScreen.main.bounds.width
        
      let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
      flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
      flowLayout.minimumInteritemSpacing = 16
      flowLayout.minimumLineSpacing = 16
        
      let itemW = (width - 48) / 2
      return CGSize(width: itemW, height: itemW * 1.6)
      }
}
