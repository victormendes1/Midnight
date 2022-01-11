//
//  MainMovieTableViewCell.swift
//  Movie2You
//
//  Created by Victor Mendes on 08/01/22.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie

class MainMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private let likeButtonView = AnimationView(name: "likedAnimation")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureBindings()
        configureFrameAnimation()
    }
    // MARK: - Configure
    func configure(_ movie: Movie) {
        titleLabel.text = movie.originalTitle
        likeLabel.text = "\(movie.voteCount)K Likes"
        viewsLabel.text = "\(movie.popularity) Views"
    }
    // MARK: - Bindings
    func configureBindings() {
        likeButton.rx
            .tap
            .subscribe(onNext: {
                self.changeLikeButtonState()
            })
            .disposed(by: disposeBag)
    }
    // MARK: - Private Functions
    //
    private func changeLikeButtonState() {
        let heartFill = UIImage(systemName: "heart.fill")
        let heartEmpty = UIImage(systemName: "heart")
        if likeButton.currentImage == heartFill {
            likeButton.setImage(heartEmpty, for: .normal)
            likeButtonView.play(fromFrame: 3, toFrame: 0)
        } else {
            likeButton.setImage(heartFill, for: .normal)
            likeButtonView.play()
        }
    }
    
    private func configureFrameAnimation() {
        likeButtonView.frame = CGRect(x: -13, y: 59, width: 80, height: 80)
        contentView.addSubview(likeButtonView)
    }
}
