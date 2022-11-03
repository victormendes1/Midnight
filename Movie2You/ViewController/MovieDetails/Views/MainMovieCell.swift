//
//  MainMovieCell.swift
//  Movie2You
//
//  Created by Victor Mendes on 31/10/22.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie
import SnapKit

class MainMovieCell: UITableViewCell {
    static let identifier = "MainMovieCell"
    
    private let disposeBag = DisposeBag()
    private let likeView = AnimationView(name: "likedAnimation")
    
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
        return button
    }()
    
    private lazy var customBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 0.5 * 40
        view.backgroundColor = .white.withAlphaComponent(0.8)
        return view
    }()
    
    private var numberOfLikesLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: "Subhead", size: 10)
        label.textColor = .white
        return label
    }()
    
    private var previewIconView: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "play.tv"))
        image.tintColor = .white
        return image
    }()
    
    private var numberOfViewsLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: "Subhead", size: 10)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureBindings()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(_ movie: Movie) {
        titleLabel.text = movie.originalTitle
        numberOfLikesLabel.text = Double(movie.voteCount).shortening(numbers: "Likes")
        numberOfViewsLabel.text = movie.popularity.removeFloatingPoint().shortening(numbers: "Views")
    }
    
    // MARK: - Bindings
    func configureBindings() {
        likeButton.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.changeLikeButtonState()
            }).disposed(by: disposeBag)
    }
    
    // MARK: - Private Functions
    private func changeLikeButtonState() {
        let heartFill = UIImage(systemName: "heart.fill")
        let heartEmpty = UIImage(systemName: "heart")
        if likeButton.currentImage == heartFill {
            likeButton.setImage(heartEmpty, for: .normal)
            likeView.play(fromFrame: 3, toFrame: 0)
        } else {
            likeButton.setImage(heartFill, for: .normal)
            likeView.play()
        }
    }
    
    private func setupViews() {
        backgroundColor = .clear
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(numberOfLikesLabel)
        contentView.addSubview(likeView)
        contentView.addSubview(customBackgroundView)
        contentView.addSubview(numberOfViewsLabel)
        contentView.addSubview(previewIconView)
        customBackgroundView.addSubview(likeButton)
        
        titleLabel.snp.makeConstraints { title in
            title.top.equalToSuperview().inset(10)
            title.leading.equalToSuperview().inset(16)
            title.trailing.equalTo(customBackgroundView.snp_leadingMargin).inset(-20)
            title.height.greaterThanOrEqualTo(15)
        }
        
        likeButton.snp.makeConstraints { button in
            button.centerY.centerX.equalTo(customBackgroundView)
            button.width.equalTo(30)
            button.height.equalTo(25)
        }
        
        customBackgroundView.snp.makeConstraints { button in
            button.top.right.equalToSuperview().inset(10)
            button.width.height.equalTo(40)
        }
        
        numberOfLikesLabel.snp.makeConstraints { likes in
            likes.top.equalTo(titleLabel.snp_bottomMargin).inset(-20)
            likes.leading.equalTo(likeView.snp_trailingMargin).inset(20)
            likes.bottom.equalToSuperview().inset(10)
            likes.height.greaterThanOrEqualTo(15)
        }
        
        likeView.snp.makeConstraints { icon in
            icon.centerY.equalTo(numberOfLikesLabel)
            icon.leading.equalToSuperview().inset(-18)
            icon.width.height.equalTo(90)
        }
        
        previewIconView.snp.makeConstraints { icon in
            icon.centerY.equalTo(numberOfLikesLabel)
            icon.left.equalTo(numberOfLikesLabel.snp_rightMargin).inset(-25)
        }
        
        numberOfViewsLabel.snp.makeConstraints { views in
            views.centerY.equalTo(previewIconView)
            views.leading.equalTo(previewIconView).inset(32)
        }
    }
}
