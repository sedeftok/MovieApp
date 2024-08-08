//
//  Client.swift
//  tmdbMovie
//
//  Created by sedef tok on 5.08.2024.
//

import Foundation
import Alamofire

protocol HttpClientProtocol {
    func fetchData(completion: @escaping ([MovieListResult]) -> Void)
    func fetchDataDetail(id: Int, completion: @escaping (MovieDetailData) -> Void)
}

class HttpClient: HttpClientProtocol {

    func fetchData(completion: @escaping ([MovieListResult]) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=db9c2d74d729b3f0e6aead1f427dc834"
        AF.request(url, method: .get).responseDecodable(of: MovieListData.self) { response in
            if let error = response.error {
                print(error)
            }
            guard let data = response.value else { return }
            guard let resultData = data.results else { return }
            completion(resultData)
        }
    }
    
    func fetchDataDetail(id: Int, completion: @escaping (MovieDetailData) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)?api_key=db9c2d74d729b3f0e6aead1f427dc834"
        AF.request(url, method: .get).responseDecodable(of: MovieDetailData.self) { response in
            if let error = response.error {
                print(error)
            }
            guard let data = response.value else { return }
            completion(data)

        }
    }
}
