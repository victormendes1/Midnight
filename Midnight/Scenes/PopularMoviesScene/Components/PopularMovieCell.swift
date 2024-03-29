//
//  PopularMovieCell.swift
//  Midnight
//
//  Created by Victor Mendes on 06/11/22.
//

import UIKit
import Kingfisher
import SnapKit

final class PopularMovieCell: UICollectionViewCell {
    private let posterView = UIImageView()
    
    // MARK: - Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        posterView.alpha = .zero
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configure
    func configure(_ movie: Movie) {
        posterView.kf.setImage(with: movie.posterURL) { _ in
            self.startAnimation()
        }
    }
    
    // MARK: - Private Function
    private func setupViews() {
        contentView.addSubview(posterView)
        posterView.layer.cornerRadius = 6
        posterView.layer.masksToBounds = true
       
        posterView.snp.makeConstraints { view in
            view.top.bottom.left.right.equalToSuperview()
        }
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 0.8, delay: 0, options: .curveEaseOut, animations: {
            self.posterView.alpha = 1
        })
    }
}

// MARK: - Extension
extension PopularMovieCell {
    static let identifer = "PopularMovieCell"
}
