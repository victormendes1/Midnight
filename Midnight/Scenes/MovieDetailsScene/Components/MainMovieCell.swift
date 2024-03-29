//
//  MainMovieCell.swift
//  Midnight
//
//  Created by Victor Mendes on 31/10/22.
//

import UIKit
import Lottie
import SnapKit

protocol MovieFavoriteEventDelegate: AnyObject {
    func favoriteMovie(liked: Bool)
}

final class MainMovieCell: UITableViewCell {
    // MARK: - Properties
    weak var delegate: MovieFavoriteEventDelegate?
    
    private let likeView = LottieAnimationView(name: "likedAnimation")
    private let heartFill = UIImage(systemName: "heart.fill")
    private let heartEmpty = UIImage(systemName: "heart")
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .poppins(type: .ExtraBold, size: 25)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 2
        label.textColor = .white
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.tintColor = .systemRed
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var customBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 0.5 * 35
        view.backgroundColor = .opaqueSeparator.withAlphaComponent(0.17)
        return view
    }()
    
    private var numberOfLikesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private var previewIconView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "play.tv"))
        image.preferredSymbolConfiguration = UIImage.SymbolConfiguration(weight: .thin)
        image.tintColor = .white
        return image
    }()
    
    private var numberOfViewsLabel: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .opaqueSeparator
        label.text = "Likes"
        return label
    }()
    
    private let viewsLabel:  UILabel = {
        let label = UILabel()
        label.textColor = .opaqueSeparator
        label.text = "Views"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 10
        label.font =  .systemFont(ofSize: 14, weight: .light)
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font =  .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(_ movie: Movie) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        releaseDateLabel.text = "Released in \(movie.release.longFormattedDate())"
        numberOfLikesLabel.text = Double(movie.voteCount).shortening()
        numberOfViewsLabel.text = movie.popularity.removeFloatingPoint().shortening()
        
        movie.liked ? likeButton.setImage(heartFill, for: .normal) : likeButton.setImage(heartEmpty, for: .normal)
        movie.liked ? likeView.play() : likeView.play(fromFrame: 3, toFrame: 0)
    }
    
    // MARK: - Private Functions
    private func changeLikeButtonState() {
        if likeButton.currentImage == heartFill {
            likeButton.setImage(heartEmpty, for: .normal)
            likeView.play(fromFrame: 3, toFrame: 0)
            delegate?.favoriteMovie(liked: false)
        } else {
            likeButton.setImage(heartFill, for: .normal)
            likeView.play()
            delegate?.favoriteMovie(liked: true)
        }
    }
    
    @objc private func likeButtonPressed() {
        changeLikeButtonState()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(numberOfLikesLabel)
        contentView.addSubview(likesLabel)
        contentView.addSubview(likeView)
        contentView.addSubview(customBackgroundView)
        contentView.addSubview(numberOfViewsLabel)
        contentView.addSubview(viewsLabel)
        contentView.addSubview(previewIconView)
        contentView.addSubview(overviewLabel)
        contentView.addSubview(releaseDateLabel)
        customBackgroundView.addSubview(likeButton)
        
        titleLabel.snp.makeConstraints { title in
            title.top.equalToSuperview().inset(10)
            title.leading.equalToSuperview().inset(16)
            title.trailing.equalTo(customBackgroundView.snp_leadingMargin).inset(-20)
            title.height.greaterThanOrEqualTo(15)
        }
        
        likeButton.snp.makeConstraints { button in
            button.centerY.equalTo(customBackgroundView).offset(1)
            button.centerX.equalTo(customBackgroundView)
            button.width.equalTo(25)
            button.height.equalTo(20)
        }
        
        customBackgroundView.snp.makeConstraints { button in
            button.centerY.equalTo(titleLabel)
            button.right.equalToSuperview().inset(20)
            button.width.height.equalTo(35)
        }
        
        numberOfLikesLabel.snp.makeConstraints { likes in
            likes.top.equalTo(titleLabel.snp_bottomMargin).inset(-20)
            likes.leading.equalTo(likeView.snp_trailingMargin).inset(20)
            likes.height.greaterThanOrEqualTo(15)
        }
        
        likesLabel.snp.makeConstraints { likes in
            likes.left.equalTo(numberOfLikesLabel.snp_rightMargin).offset(10)
            likes.centerY.equalTo(numberOfLikesLabel)
        }
        
        likeView.snp.makeConstraints { icon in
            icon.centerY.equalTo(numberOfLikesLabel)
            icon.leading.equalToSuperview().inset(-18)
            icon.width.height.equalTo(90)
        }
        
        previewIconView.snp.makeConstraints { icon in
            icon.centerY.equalTo(numberOfLikesLabel)
            icon.left.equalTo(likesLabel.snp_rightMargin).inset(-25)
        }
        
        numberOfViewsLabel.snp.makeConstraints { views in
            views.centerY.equalTo(previewIconView)
            views.leading.equalTo(previewIconView).inset(32)
        }
        
        viewsLabel.snp.makeConstraints { views in
            views.left.equalTo(numberOfViewsLabel.snp_rightMargin).inset(-8)
            views.centerY.equalTo(numberOfViewsLabel)
        }
        
        overviewLabel.snp.makeConstraints { details in
            details.top.equalTo(numberOfLikesLabel.snp_bottomMargin).inset(-14)
            details.left.equalToSuperview().inset(16)
            details.right.equalToSuperview().inset(16)
        }
        
        releaseDateLabel.snp.makeConstraints { date in
            date.top.equalTo(overviewLabel.snp_bottomMargin).inset(-12)
            date.left.equalToSuperview().inset(16)
            date.right.equalToSuperview().inset(16)
            date.bottom.equalToSuperview().inset(10)
        }
    }
}

// MARK: - Extension ID
extension MainMovieCell {
    static let identifier = "MainMovieCell"
}
