//
//  SimilarMoviesTableViewCell.swift
//  Movie2You
//
//  Created by Victor Mendes on 08/01/22.
//

import UIKit
import Moya
import Resolver
import Kingfisher

class SimilarMoviesTableViewCell: UITableViewCell {
    @IBOutlet weak var movieBackgroundImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ movie: Movies) {
        movieBackgroundImage.kf.setImage(with: movie.posterURL())
        titleLabel.text = movie.originalTitle
        releaseLabel.text = movie.releaseDate.onlyYear()
        genreLabel.text = movie.getGenres()
    }
}
