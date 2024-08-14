//
//  MovieListCollectionViewCell.swift
//  tmdbMovie
//
//  Created by sedef tok on 6.08.2024.
//

import UIKit
import Kingfisher

protocol MovieListCollectionProtocol {
    func favoriteTapped(data: MovieListResult)
}

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
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "heart"), for: .normal) // Kalp simgesi
           //button.setImage(UIImage(systemName: "heart.fill"), for: .selected) // Dolmuş kalp simgesi
            button.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
            return button
    }()
    
    var cellDelegate: MovieListCollectionProtocol?
    var movieData: MovieListResult?
    var isSelectedMovie = false
    var favoriteButtonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func favoriteButtonTapped() {
        //favoriteButton.isSelected.toggle()
        guard let data = movieData else { return }
        cellDelegate?.favoriteTapped(data: data)
        
        if isSelectedMovie {
            isSelectedMovie = false
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
         
        }else{
            isSelectedMovie = true
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
           
        }
    }
    
   /* private func updateFavoriteButton() {
           guard let movieData = movieData else { return }
           favoriteButton.isSelected = isMovieFavorite(movieData)
       }*/
    
    func configure() {
        configureCell()
    }
    
    private func configureCell() {
        configureUI()
    }
    
    private func configureUI() {
        contentView.addSubview(image)
        contentView.addSubview(movieName)
        contentView.addSubview(favoriteButton)
        
        self.layer.cornerRadius = Constant.viewCornerRadius
        self.layer.borderWidth = Constant.viewCornerLineWidth
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 8
        
        makeConstraints()
    }
    
    func saveModel(data: MovieListResult, isSelected: Bool) {
        self.movieData = data
        movieName.text = data.title
        self.isSelectedMovie = isSelected
        
        let imageURl = "https://image.tmdb.org/t/p/w500\(data.posterPath ?? "")"
        if let url = URL(string: imageURl) {
            image.kf.setImage(with: url)
        }
        
        if isSelected {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            print(data.title)
        }else{
            favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        // Favori durumu güncelle
        //favoriteButton.isSelected = data.isFavorite
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
        
        favoriteButton.snp.makeConstraints { make in
                       make.top.equalToSuperview().offset(8)
                       make.right.equalToSuperview().offset(-8)
                       make.width.height.equalTo(40) // Buton boyutu
        }
    }
}

