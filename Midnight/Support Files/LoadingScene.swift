//
//  LoadingScene.swift
//  Midnight
//
//  Created by Victor Mendes on 31/01/23.
//

import UIKit

final class LoadingScene {
    class func showLoadingView(_ show: Bool) {
        guard let loadingView = self.configureLoadingView(withFrame: UIScreen.main.bounds) else { return }
        let existingView = UIApplication.shared.windows.first?.viewWithTag(1200)
        
        if show {
            if existingView != nil { return }
            loadingView.alpha = 0
            UIApplication.shared.windows.first?.addSubview(loadingView)
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn) {
                loadingView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut) {
                existingView?.alpha = 0
            } completion: { _ in
                existingView?.removeFromSuperview()
            }
        }
    }
    
    private class func configureLoadingView(withFrame frame: CGRect) -> UIView? {
        let loadingView = UIView(frame: frame)
        loadingView.tag = 1200
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        activityIndicator.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        activityIndicator.layer.cornerRadius = 10
        activityIndicator.center = loadingView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        activityIndicator.color = .white
        activityIndicator.startAnimating()
        loadingView.addSubview(activityIndicator)
        return loadingView
    }
}
