//
//  MovieListVC.swift
//  tmdbMovie
//
//  Created by sedef tok on 5.08.2024.
//

import UIKit
import SnapKit

class MovieListVC: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView( frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
        return collectionView
    }()
    
    var movieViewModel: MovieListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieViewModel?.loadMovieList()
        
        initDelegate()
    }
    
    private func initDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        movieViewModel?.delegate = self
        
        configure()
    }
    
    private func configure() {
        collectionView.backgroundColor = .systemGreen
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        
        movieCollectionView()
    }
    
    
    
    private func movieCollectionView() {
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalTo(view)
        }
    }
}

extension MovieListVC: MovieListViewModelDelegate {
    func getMovieData(data: [MovieListResult]) {
        collectionView.reloadData()
        print(data)
    }
}


extension MovieListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell()
      }
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let column = 1
        let width = collectionView.frame.size.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        let w = width / 1
        let h = w * 0.6
        return CGSize(width: w, height: h)
    }
}
