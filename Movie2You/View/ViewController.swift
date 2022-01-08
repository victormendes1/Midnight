//
//  ViewController.swift
//  Movie2You
//
//  Created by Victor Mendes on 07/01/22.
//

import UIKit
import Moya
import Resolver

class ViewController: UIViewController {
    fileprivate var viewModel: ViewModel = Resolver.resolve()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //viewModel.requestMovies()
        viewModel.requestSimilarMovies()
    }
}
