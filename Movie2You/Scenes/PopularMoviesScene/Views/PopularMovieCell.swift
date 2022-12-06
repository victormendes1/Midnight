//
//  PopularMovieCell.swift
//  Movie2You
//
//  Created by Victor Mendes on 06/11/22.
//

import UIKit
import Kingfisher
import SnapKit


class PopularMovieCell: UICollectionViewCell {
    let posterView = UIImageView()
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
    
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

    func configure(_ movie: Movie) {
        posterView.kf.setImage(with: movie.posterURL)
    }
    
    private func setupViews() {
        contentView.addSubview(posterView)
        
        posterView.snp.makeConstraints { view in
            view.width.height.equalToSuperview()
        }
    }
}

extension PopularMovieCell {
    static let identifer = "PopularMovieCell"
}
