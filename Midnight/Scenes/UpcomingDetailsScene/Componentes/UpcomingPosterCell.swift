//
//  UpcomingPosterCell.swift
//  Midnight
//
//  Created by Victor Mendes on 15/12/22.
//

import UIKit
import SnapKit
import Lottie
import Kingfisher

final class UpcomingPosterCell: UITableViewCell {
    // MARK: - Properties
    private let playerView = VideoView()
    private let playButtonView = LottieAnimationView(name: "loadingAnimation")
    private let posterImageView = UIImageView()
    private var videoID = String()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(type: .Bold, size: 22)
        label.textColor = .white
        label.numberOfLines = 3
        return label
    }()
    
    private let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let genresLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    private let durationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let overviewTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.numberOfLines = 20
        return label
    }()
    
    private let playTrailerButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        return button
    }()
    
    private lazy var playBackgroundButtonView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.cornerRadius = 0.5 * 51
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 6
        view.addSubview(playButtonView)
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        posterImageView.alpha = .zero
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(_ movie: Movie) {
        titleLabel.text = movie.title
        overviewTextLabel.text = movie.overview
        genresLabel.text = formattedGenres(movie.genreId)
        durationLabel.text = durationWithHyphen(movie)
        releaseYearLabel.text = "Expected release \(movie.release.longFormattedDate())"
        videoID = movie.trailerID ?? ""
        posterImageView.kf.setImage(with: movie.backdropURL) { _ in
            self.startAnimation()
        }
    }
    
    // MARK: - Private Functions
    private func setupViews() {
        backgroundColor = .black
        contentView.addSubview(playerView)
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseYearLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(durationLabel)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(overviewTextLabel)
        contentView.addSubview(playBackgroundButtonView)
        contentView.addSubview(playTrailerButton)
        
        playerView.snp.makeConstraints { video in
            video.top.equalToSuperview()
            video.width.equalToSuperview()
            video.height.equalTo(230)
        }
        
        posterImageView.snp.makeConstraints { poster in
            poster.width.height.equalTo(playerView)
        }
        
        titleLabel.snp.makeConstraints { title in
            title.top.equalTo(playerView.snp_bottomMargin).offset(20)
            title.left.equalToSuperview().inset(16)
            title.right.equalToSuperview().inset(16)
        }
        
        genresLabel.snp.makeConstraints { genres in
            genres.top.equalTo(titleLabel.snp_bottomMargin).offset(12)
            genres.left.equalToSuperview().inset(16)
        }
        
        durationLabel.snp.makeConstraints { time in
            time.centerY.equalTo(genresLabel)
            time.left.equalTo(genresLabel.snp.rightMargin).offset(12)
        }
        
        releaseYearLabel.snp.makeConstraints { release in
            release.top.equalTo(genresLabel.snp_bottomMargin).offset(10)
            release.left.equalToSuperview().offset(16)
        }
        
        
        overviewLabel.snp.makeConstraints { overview in
            overview.top.equalTo(releaseYearLabel.snp_bottomMargin).offset(26)
            overview.left.equalToSuperview().inset(16)
        }
        
        overviewTextLabel.snp.makeConstraints { overview in
            overview.top.equalTo(overviewLabel.snp_bottomMargin).offset(16)
            overview.left.right.equalToSuperview().inset(16)
            overview.bottom.equalToSuperview().inset(10)
        }
        
        playTrailerButton.snp.makeConstraints { play in
            play.centerY.centerX.equalTo(posterImageView)
            play.height.width.equalTo(50)
        }
        
        playBackgroundButtonView.snp.makeConstraints { background in
            background.centerY.centerX.equalTo(playButtonView)
            background.width.height.equalTo(51)
        }
        
        playButtonView.snp.makeConstraints { play in
            play.centerX.centerY.equalTo(playTrailerButton)
            play.height.width.equalTo(60)
        }
        
        posterImageView.contentMode = .scaleAspectFill
    }
    
    private func formattedGenres(_ genresID: [Int]?) -> String {
        let genres = GenresAccessObject.organizedGenres(genresID)
        return genres.replacingOccurrences(of: ",", with: " •")
    }
    
    private func durationWithHyphen(_ movie: Movie) -> String {
        "- \(movie.duration?.formattedDuration ?? "")"
    }
    
    @objc private func playVideo() {
        playerView.loadVideo(videoID: videoID)
        playButtonView.animationSpeed = 0.5
        playButtonView.play()
        
        UIView.animate(withDuration: 0.3, delay: 4, options: .curveEaseIn) {
            self.posterImageView.alpha = 0
            self.playTrailerButton.alpha = 0
            self.playButtonView.alpha = 0
            self.playBackgroundButtonView.alpha = 0
        }
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
            self.posterImageView.alpha = 1
        })
    }
}

// MARK: - Extension
extension UpcomingPosterCell {
    static let identifier = "UpcomingPosterCell"
}
