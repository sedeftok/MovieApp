//
//  MovieListViewModel.swift
//  tmdbMovie
//
//  Created by sedef tok on 5.08.2024.
//

import Foundation

protocol MovieListViewModelProtocol {
    var delegate: MovieListViewModelDelegate? { get set }
    func loadMovieList()
}

protocol MovieListViewModelDelegate {
    func getMovieData(data: [MovieListResult])
}

class MovieListViewModel: MovieListViewModelProtocol {
    var delegate: MovieListViewModelDelegate?
    var client: HttpClientProtocol?
    
    init(client: HttpClientProtocol) {
        self.client = client
    }
}

extension MovieListViewModel {
    func loadMovieList() {
        client?.fetchData(completion: { movieData in
            self.delegate?.getMovieData(data: movieData)
        })
    }
}
