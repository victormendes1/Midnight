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
        let button = UIButton(frame: CGRect(x: 100, y: 400, width: 200, height: 60))
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.setTitle("Tela de detalhes", for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
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
