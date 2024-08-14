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
    
    func getMovieData() -> [MovieListResult]
    func getMovieDataCount() -> Int
    func updateMovieData(at index: Int, with movie: MovieListResult)
}

protocol MovieListViewModelDelegate {
    func success()
}

class MovieListViewModel: MovieListViewModelProtocol {
    var delegate: MovieListViewModelDelegate?
    var client: HttpClientProtocol?
    var movieData: [MovieListResult] = []
    
    init(client: HttpClientProtocol) {
        self.client = client
    }
}

extension MovieListViewModel {
    func loadMovieList() {
        client?.fetchData(completion: { movieData in
            self.movieData = movieData
            self.delegate?.success()
        })
    }
    
    func getMovieData() -> [MovieListResult] {
        movieData
    }
    
    func getMovieDataCount() -> Int {
        movieData.count
    }
    
    func updateMovieData(at index: Int, with movie: MovieListResult) {
            guard index >= 0 && index < movieData.count else { return }
            movieData[index] = movie
        }
}

