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
import RxGesture

class MainMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!

    private let disposeBag = DisposeBag()
    private let likeButtonView = AnimationView(name: "likedAnimation")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureBindings()
        configureAnimation()
    }
    
    func configure(_ movie: Movie) {
        titleLabel.text = movie.originalTitle
        likeLabel.text = "\(movie.voteCount)K Likes"
        viewsLabel.text = "\(movie.popularity) Views"
    }
    
    func configureBindings() {
        likeButtonView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.likeButtonView.play()
                //self.likeButtonView.play(fromFrame: 25, toFrame: 0, loopMode: .none)
            })
            .disposed(by: disposeBag)
    }
    
    private func configureAnimation() {
        likeButtonView.frame = CGRect(x: 290, y: -30, width: 120, height: 120)
        contentView.addSubview(likeButtonView)
        
        likeButtonView.play(fromFrame: 0, toFrame: 0, loopMode: .none)
    }
}
