//
//  MovieListVC.swift
//  tmdbMovie
//
//  Created by sedef tok on 5.08.2024.
//

import UIKit
import SnapKit

class MovieListVC: UIViewController {

    var movieViewModel: MovieListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        movieViewModel?.loadMovieList()
        
        initDelegate()
    }
    
    private func initDelegate() {
        movieViewModel?.delegate = self
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
    }
}

extension MovieListVC: MovieListViewModelDelegate {
    func getMovieData(data: [MovieListResult]) {
        print(data)
    }
}
