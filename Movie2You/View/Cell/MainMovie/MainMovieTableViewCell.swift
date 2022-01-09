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
        likeLabel.text = "\(movie.voteCount) Likes"
        viewsLabel.text = "\(movie.popularity)K Views"
    }
    
    func configureBindings() {
        likeButton.rx
            .tap
            .subscribe(onNext: {
                self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) //TODO: - Adicionar animação e finalizar essa função.
            })
            .disposed(by: disposeBag)
    }
}
