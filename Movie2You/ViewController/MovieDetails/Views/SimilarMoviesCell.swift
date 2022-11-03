//
//  SimilarMoviesCell.swift
//  Movie2You
//
//  Created by Victor Mendes on 31/10/22.
//


import Moya
import Resolver
import Kingfisher
import UIKit
import SnapKit

class SimilarMoviesCell: UITableViewCell {
    static let identifier = "SimilarMoviesCell"
    
    private let movieBackgroundImage = UIImageView ()
   
    private var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryLabel
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private var releaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieBackgroundImage.alpha = 0
    }
    
    // MARK: - Configure
    func configure(_ movie: Movies) {
        backgroundColor = .clear
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.movieBackgroundImage.alpha = 1
        })
        movieBackgroundImage.kf.setImage(with: movie.posterURL())
        titleLabel.text = movie.originalTitle
        releaseLabel.text = movie.releaseYear
        genreLabel.text = movie.getGenres()
        
        setupViews()
    }
    
    // MARK: - Private Functions
    private func setupViews() {
        contentView.addSubview(movieBackgroundImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(separatorView)
        
        separatorView.snp.makeConstraints { line in
            line.left.equalToSuperview().inset(90)
            line.right.equalToSuperview()
            line.bottom.equalToSuperview()
            line.height.equalTo(0.3)
        }
        
        movieBackgroundImage.snp.makeConstraints { image in
            image.top.equalToSuperview().inset(10)
            image.left.equalToSuperview().inset(16)
            image.right.equalTo(separatorView.snp_rightMargin)
            image.bottom.equalTo(separatorView).inset(10)
            image.height.equalTo(85)
            image.width.equalTo(60)
        }
        
        titleLabel.snp.makeConstraints { title in
            title.centerY.equalTo(45)
            title.left.equalTo(movieBackgroundImage.snp_rightMargin).inset(-20)
            title.trailing.equalToSuperview().inset(10)
        }
        
        releaseLabel.snp.makeConstraints { subTitle in
            subTitle.top.equalTo(titleLabel.snp_bottomMargin).inset(-10)
            subTitle.leading.equalTo(titleLabel)
        }
        
        genreLabel.snp.makeConstraints { genre in
            genre.left.equalTo(releaseLabel.snp_rightMargin).inset(-15)
            genre.centerY.equalTo(releaseLabel)
        }
    }
}
