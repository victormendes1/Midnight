//
//  MovieListViewController.swift
//  Movie2You
//
//  Created by Victor Mendes on 31/10/22.
//

import UIKit
import RxCocoa
import RxSwift

class MovieListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private var nextScreen: UIButton = {
        let button = UIButton(frame: CGRect(x: 50, y: 100, width: 100, height: 80))
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(nextScreen)
        
        nextScreen.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                let vc = MovieDetailsViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }).disposed(by: disposeBag)
    }
}
