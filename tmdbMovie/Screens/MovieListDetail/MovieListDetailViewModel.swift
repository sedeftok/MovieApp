//
//  MovieListDetailViewModel.swift
//  tmdbMovie
//
//  Created by sedef tok on 8.08.2024.
//

import Foundation

protocol MovieListDetailViewModelProtocol {
    var delegate: MovieListDetailViewModelDelegate? { get set }
    func loadDetailPage()
    func getMovieDetailData() -> MovieDetailData?
}

protocol MovieListDetailViewModelDelegate {
    func success()
}

class MovieListDetailViewModel: MovieListDetailViewModelProtocol {
    var delegate: MovieListDetailViewModelDelegate?
    var detail: MovieDetailData?
    private var id: Int
    private var httpClient: HttpClientProtocol?
    
    init(id: Int, httpClient: HttpClientProtocol) {
        self.id = id
        self.httpClient = httpClient
        self.delegate?.success()
    }
}

extension MovieListDetailViewModel {
    func loadDetailPage() {
        httpClient?.fetchDataDetail(id: id, completion: { detail in
            self.detail = detail
            self.delegate?.success()
        })
    }
    
    func getMovieDetailData() -> MovieDetailData? {
        return detail
    }
}

 
