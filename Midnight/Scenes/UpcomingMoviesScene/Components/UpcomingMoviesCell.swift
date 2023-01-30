//
//  UpcomingMoviesCell.swift
//  Midnight
//
//  Created by Victor Mendes on 14/12/22.
//

import UIKit
import SnapKit
import Kingfisher
import Lottie

final class UpcomingMoviesCell: UITableViewCell {
    private let moviePosterImage = UIImageView()
    private let separatorView = UIView()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 3
        label.font = .poppins(type: .Bold, size: 18)
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        moviePosterImage.alpha = .zero
        titleLabel.alpha = .zero
        genresLabel.alpha = .zero
        releaseDateLabel.alpha = .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(_ movie: Movie) {
        titleLabel.text = movie.title
        genresLabel.text = formattedGenres(movie.genreId)
        releaseDateLabel.text = "Release on " + movie.release.longFormattedDate()
        moviePosterImage.kf.setImage(with: movie.posterURL) { _ in
            self.startAnimation()
        }
    }
    
    // MARK: - Private Functions
    private func setupViews() {
        backgroundColor = .clear
        separatorView.backgroundColor = .secondaryLabel
        
        contentView.addSubview(moviePosterImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(separatorView)
        
        moviePosterImage.snp.makeConstraints { poster in
            poster.top.equalToSuperview().inset(10)
            poster.left.equalToSuperview().inset(16)
            poster.bottom.equalTo(separatorView).inset(10)
            poster.height.equalTo(120)
            poster.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { title in
            title.centerY.equalToSuperview().offset(-20)
            title.left.equalTo(moviePosterImage.snp_rightMargin).offset(20)
            title.right.equalToSuperview().inset(16)
        }
        
        genresLabel.snp.makeConstraints { genres in
            genres.top.equalTo(titleLabel.snp_bottomMargin).offset(10)
            genres.left.equalTo(moviePosterImage.snp_rightMargin).offset(20)
            genres.right.equalToSuperview().inset(16)
        }
        
        releaseDateLabel.snp.makeConstraints { subtitle in
            subtitle.left.equalTo(moviePosterImage.snp_rightMargin).offset(20)
            subtitle.right.equalToSuperview().inset(16)
            subtitle.bottom.equalTo(separatorView).inset(10)
        }
        
        separatorView.snp.makeConstraints { line in
            line.left.right.equalToSuperview()
            line.bottom.equalToSuperview()
            line.height.equalTo(0.7)
        }
    }
    
    private func formattedGenres(_ genresID: [Int]?) -> String {
        let genres = GenresAccessObject.organizedGenres(genresID)
        return genres.replacingOccurrences(of: ",", with: " •")
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.moviePosterImage.alpha = 1
            self.titleLabel.alpha = 1
            self.genresLabel.alpha = 1
            self.releaseDateLabel.alpha = 1
        })
    }
}

// MARK: - Extension
extension UpcomingMoviesCell {
    static let identifer = "UpcomingMoviesCell"
}
