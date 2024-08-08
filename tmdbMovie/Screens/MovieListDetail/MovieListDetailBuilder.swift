//
//  MovieListDetailBuilder.swift
//  tmdbMovie
//
//  Created by sedef tok on 8.08.2024.
//

import Foundation
import Alamofire
import UIKit

class MovieListDetailBuilder {
    static func makeMovieList(id: Int) -> MovieListDetailVC {
        let vc = MovieListDetailVC()
        let client = HttpClient()
        let viewModel = MovieListDetailViewModel(id: id, httpClient: client)
        vc.movieDetailViewModel = viewModel
        return vc
    }
}
