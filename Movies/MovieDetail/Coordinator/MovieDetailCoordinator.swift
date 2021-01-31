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
    print(self)
    print("deinit")
  }
  
  func start() {
    presenter.pushViewController(controller, animated: true)
    controller.coordinator = self
  }
  
  func showMovies(using movie: NetworkMovie) {
    let moviesCoordinator = MoviesCoordinator(presenter: presenter, moviesDataType: .similar(movie))
    childCoordinators.append(moviesCoordinator)
    moviesCoordinator.start()
  }
}
