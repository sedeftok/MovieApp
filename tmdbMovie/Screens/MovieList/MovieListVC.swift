//
//  MovieListVC.swift
//  tmdbMovie
//
//  Created by sedef tok on 5.08.2024.
//

import UIKit
import SnapKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

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
    let context = appDelegate.persistentContainer.viewContext
    var favMovieList: [FavoriteMovie] = []
    var isSelectedMovie = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieViewModel?.loadMovieList()
        
        navigationItem.title = "Movies"
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 22)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Favorites", style: .plain, target: self, action: #selector(showFavorites))
        
        initDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCoreData()
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
    
    private func addCoreData(data: MovieListResult) {
        let movie = FavoriteMovie(context: context)
        
        movie.id = String(data.id ?? 0)
        movie.title = data.title
        movie.poster = data.posterPath
        
        appDelegate.saveContext()
    }
    
    private func deleteCoreData(data: MovieListResult) {
        for (index, list) in favMovieList.enumerated() {
            if list.title == data.title {
                
                let movie = self.favMovieList[index]
                
                self.context.delete(movie)
                
                appDelegate.saveContext()
            }
        }
    }
    
    private func fetchCoreData() {
        do {
            favMovieList = try context.fetch(FavoriteMovie.fetchRequest())
            //print(favMovieList)
            for n in favMovieList {
                print(n.title)
                print(n.poster)
            }
        } catch  {
            print(error)
            
        }
    }
    
    private func isSelected(data: MovieListResult) -> Bool {
        return favMovieList.contains(where: { $0.title == data.title  &&  $0.poster == data.posterPath })
    }
    
    @objc private func showFavorites() {
        let favoritesViewController = FavoritesVC()
        favoritesViewController.favMovieList = self.favMovieList
        navigationController?.pushViewController(favoritesViewController, animated: true)
    }
}

extension MovieListVC: MovieListViewModelDelegate {
    func success() {
        collectionView.reloadData()
    }
}

extension MovieListVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MovieListCollectionProtocol {
    
    func favoriteTapped(data: MovieListResult) {
        if isSelected(data: data) {
               deleteCoreData(data: data)
           } else {
               addCoreData(data: data)
           }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieViewModel?.getMovieDataCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell()
        }
        guard let dataTwo = movieViewModel?.getMovieData() else { return cell }
        let data = dataTwo[indexPath.row]
        cell.configure()
        cell.cellDelegate = self
        let isSelected = isSelected(data: data)
        cell.saveModel(data: data, isSelected: isSelected)
        
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
