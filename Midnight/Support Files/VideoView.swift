//
//  VideoView.swift
//  Midnight
//
//  Created by Victor Mendes on 14/12/22.
//

import SnapKit
import youtube_ios_player_helper

final class VideoView: UIView {
    private var playerView = YTPlayerView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        playerView.delegate = self
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func loadVideo(videoID: String) {
        playerView.load(withVideoId: videoID, playerVars: ["playsinline": 0])
    }
    
    // MARK: - Private Function
    private func setupViews() {
        addSubview(playerView)
        playerView.snp.makeConstraints { video in
            video.width.height.equalToSuperview()
        }
    }
}

//MARK: - Extension
extension VideoView: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
