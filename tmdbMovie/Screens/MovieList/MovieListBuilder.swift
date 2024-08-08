//
//  MovieListBuilder.swift
//  tmdbMovie
//
//  Created by sedef tok on 5.08.2024.
//

import Foundation

class MovieListBuilder {
    static func makeMovieList() -> MovieListVC {
        let vc = MovieListVC()
        let client = HttpClient()
        let viewModel = MovieListViewModel(client: client)
        vc.movieViewModel = viewModel
        
        return vc
    }
}
