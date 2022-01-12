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
    @IBOutlet weak var likeView: UIView!
    private let disposeBag = DisposeBag()
    private let likeButtonView = AnimationView(name: "likedAnimation")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureBindings()
        configureFrameAnimation()
    }
    // MARK: - Configure
    func configure(_ movie: Movie) {
        likeView.backgroundColor = .clear
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
        likeButtonView.frame = likeView.frame
        likeView.addSubview(likeButtonView)
    }
}
