//
//  MovieDetailCoordinator.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import UIKit

class MovieDetailCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
//  var presenter: UINavigationController
  let controller: MovieDetailViewController
  
  init (){
//    self.presenter = presenter
    let controller = MovieDetailViewController()
    self.controller = controller
  }
  
  func start() {
//    presenter.pushViewController(controller, animated: true)
  }
}
