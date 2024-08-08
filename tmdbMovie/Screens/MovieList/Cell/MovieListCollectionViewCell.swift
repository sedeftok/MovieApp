//
//  MovieListCollectionViewCell.swift
//  tmdbMovie
//
//  Created by sedef tok on 6.08.2024.
//

import UIKit
import Kingfisher

class MovieListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieListCollectionViewCell"
    
    private enum Constant {
        static let viewCornerRadius: CGFloat = 12
        static let viewCornerLineWidth: CGFloat = 1
        static let shadowOpacity: Float = 0.5
        static let shadowRadius: CGFloat = 8
        static let shadowOffset: CGSize = CGSize(width: 0, height: 4)
        static let minOffSet: CGFloat = 8
    }
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
        image.backgroundColor = .white
        image.layer.cornerRadius = 8
        return image
    }()
    
    private lazy var movieName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19)
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    func configure() {
        configureCell()
    }
    
    private func configureCell() {
        configureUI()
    }
    
    private func configureUI() {
        contentView.addSubview(image)
        contentView.addSubview(movieName)
        
        self.layer.cornerRadius = Constant.viewCornerRadius
        self.layer.borderWidth = Constant.viewCornerLineWidth
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 8
        
        makeConstraints()
    }
    
    func saveModel(data: MovieListResult) {
        movieName.text = data.title
        
        let imageURl = "https://image.tmdb.org/t/p/w500\(data.posterPath ?? "")"
        if let url = URL(string: imageURl) {
            image.kf.setImage(with: url)
        }
    }
}

extension MovieListCollectionViewCell {
    func makeConstraints() {
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()//.offset(8)
            make.left.equalToSuperview()//.offset(8)
            make.right.equalToSuperview()//.offset(-8)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.72)
        }
        
        movieName.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
}

