//
//  SimilarMoviesCell.swift
//  Midnight
//
//  Created by Victor Mendes on 31/10/22.
//


import UIKit
import Kingfisher
import SnapKit

final class SimilarMoviesCell: UITableViewCell {
    private let movieBackgroundImage = UIImageView()
    private let separatorView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .opaqueSeparator
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        movieBackgroundImage.alpha = 0
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(_ movie: Movie) {
        backgroundColor = .clear
        titleLabel.text = movie.title
        subTitleLabel.text = "\(movie.releaseYearOnly) - \(GenresAccessObject.organizedGenres(movie.genreId))"
        movieBackgroundImage.kf.setImage(with: movie.posterURL) { _ in
            self.starAnimaton()
        }
    }
    
    // MARK: - Private Functions
    private func setupViews() {
        separatorView.backgroundColor = .secondaryLabel
        
        contentView.addSubview(movieBackgroundImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(separatorView)
        
        separatorView.snp.makeConstraints { line in
            line.left.equalToSuperview().inset(90)
            line.right.equalToSuperview()
            line.bottom.equalToSuperview()
            line.height.equalTo(0.7)
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
        
        subTitleLabel.snp.makeConstraints { subTitle in
            subTitle.top.equalTo(titleLabel.snp_bottomMargin).inset(-10)
            subTitle.left.equalTo(titleLabel)
        }
    }
    
    private func starAnimaton() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.movieBackgroundImage.alpha = 1
        })
    }
}

// MARK: - Extension ID
extension SimilarMoviesCell {
    static let identifier = "SimilarMoviesCell"
}
