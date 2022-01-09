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
    
    func configure(_ movie: Movie) {
        movieBackgroundImage.kf.setImage(with: movie.posterURL())
        titleLabel.text = movie.originalTitle
        releaseLabel.text = movie.releaseDate.onlyYear()
        genreLabel.text = movie.getGenres()
        // Filtrando a lista de gêneros de acordo com o necessário por filme
//        if let allGendersName = movie.genreId?.map { number -> String in
//            listGeners.filter{ $0.id == number }.map { $0.name }.joined()
//        }.filter({ $0 != "" }).prefix(2).joined(separator: ", ") {
//            genreLabel.text = allGendersName
//        }
    }
}
