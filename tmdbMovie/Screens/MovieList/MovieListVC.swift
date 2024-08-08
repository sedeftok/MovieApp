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
    func success() {
        collectionView.reloadData()
    }
}

extension MovieListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieViewModel?.getMovieDataCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell()
        }
        guard let data = movieViewModel?.getMovieData() else { return cell }
        cell.configure()
        cell.saveModel(data: data[indexPath.row])
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = movieViewModel?.getMovieData() else { return }
        let id = data[indexPath.row].id ?? 0
        let vc = MovieListDetailBuilder.makeMovieList(id: id)
        self.present(vc, animated: true)
        print(id)
        
    }
}
