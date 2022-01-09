//
//  MainMovieTableViewCell.swift
//  Movie2You
//
//  Created by Victor Mendes on 08/01/22.
//

import UIKit

class MainMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(_ movie: Movie) {
        titleLabel.text = movie.originalTitle
        likeLabel.text = "\(movie.voteCount) Likes"
        viewsLabel.text = "\(movie.popularity)K Views"
    }
}
