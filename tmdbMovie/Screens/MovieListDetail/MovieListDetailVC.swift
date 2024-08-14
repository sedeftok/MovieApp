//
//  MovieListDetailVC.swift
//  tmdbMovie
//
//  Created by sedef tok on 8.08.2024.
//

import UIKit
import Kingfisher

class MovieListDetailVC: UIViewController {

    private lazy var name: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    private lazy var detailImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.backgroundColor = .white
        image.layer.cornerRadius = 8
        return image
    }()
    
    var movieDetailViewModel: MovieListDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieDetailViewModel?.loadDetailPage()
        initDelegate()
    }
    private func initDelegate() {
        movieDetailViewModel?.delegate = self
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(name)
        view.addSubview(detailImage)
        makeConstraints()
    }
}

extension MovieListDetailVC: MovieListDetailViewModelDelegate {
    func success() {
        guard let data = movieDetailViewModel?.getMovieDetailData() else { return }
        name.text = data.title
        
        if let url = URL(string: "https:image.tmdb.org/t/p/w500" + data.posterPath!) {
            DispatchQueue.main.async {
                self.detailImage.kf.setImage(with: url)
            }
        }
    }
}

extension  MovieListDetailVC {
    func makeConstraints() {
        detailImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.left.equalToSuperview().offset(72)
            make.right.equalToSuperview().offset(-72)
            //make.centerX.equalToSuperview()
            make.height.equalTo(400)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(detailImage.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
    }
}
