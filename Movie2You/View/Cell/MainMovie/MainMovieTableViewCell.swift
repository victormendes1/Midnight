//
//  MainMovieTableViewCell.swift
//  Movie2You
//
//  Created by Victor Mendes on 08/01/22.
//

import UIKit
import RxSwift
import RxCocoa

class MainMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    private let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureBindings()
    }
    
    func configure(_ movie: Movie) {
        titleLabel.text = movie.originalTitle
        likeLabel.text = "\(movie.voteCount)K Likes"
        viewsLabel.text = "\(movie.popularity) Views"
    }
    
    func configureBindings() {
        likeButton.rx
            .tap
            .subscribe(onNext: likeClick)
            .disposed(by: disposeBag)
    }
    
    private func likeClick() {
        let heartFill = UIImage(systemName: "heart.fill")
        let heartEmpty = UIImage(systemName: "heart")
        if likeButton.currentImage == heartEmpty {
            likeButton.setImage(heartFill, for: .normal)
        } else {
            likeButton.setImage(heartEmpty, for: .normal)
        }
    }
}
