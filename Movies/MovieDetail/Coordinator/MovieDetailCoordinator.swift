//
//  MovieDetailCoordinator.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import UIKit

class MovieDetailCoordinator: Coordinator {
  weak var parentCoordinator: Coordinator?
  var childCoordinators: [Coordinator] = []
  var presenter: UINavigationController
  let controller: MovieDetailViewController
  
  init (presenter: UINavigationController, movie: NetworkMovie){
    self.presenter = presenter
    let controller = MovieDetailViewController()
    controller.movie = movie
    self.controller = controller
  }
  
  deinit {
    print("\(self) deinited")
  }
  
  func start() {
    presenter.pushViewController(controller, animated: true)
    controller.coordinator = self
  }
  
  func viewControllerDiDFinish() {
    childCoordinators.removeAll()
    parentCoordinator?.removeChildCoordinator(childCoordinator: self)
  }
  
  func showMovies(using movie: NetworkMovie) {
    let moviesCoordinator = MoviesCoordinator(presenter: presenter, moviesDataType: .similar(movie))
    moviesCoordinator.parentCoordinator = self
    addChildCoordinator(childCoordinator: moviesCoordinator)
    moviesCoordinator.start()
  }
}
