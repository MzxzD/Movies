//
//  TopMoviesCoordinator.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import UIKit

class MoviesCoordinator: Coordinator {
  var childCoordinators: [Coordinator] = []
  var parentCoordinator: Coordinator?
  var presenter: UINavigationController
  let controller: MoviesCollectionViewController
  let moviesDataType: MovesDataType
  
  init (presenter: UINavigationController, moviesDataType: MovesDataType ){
    self.presenter = presenter
    let flowLayout = UICollectionViewFlowLayout()
    let controller = MoviesCollectionViewController(collectionViewLayout: flowLayout)
    self.controller = controller
    self.moviesDataType = moviesDataType
    let title: String = {
      switch moviesDataType {
      case .topMovies:
        return "Top Movies"
      case .popularMovies:
        return "Popular Moves"
      case .favoriteMovies:
        return "Favorite Movies"
      case .similar(let movie):
        return "\(movie.title ?? "") Similar"
      }
    }()
    self.controller.title = title
    self.controller.coordinator = self
    self.controller.datasource = MovieDataSource(movieDataType: moviesDataType)
    self.controller.needsToLoad = moviesDataType == .favoriteMovies ? false : true
  }
  
  deinit {
    print("\(self) deinited")
  }
  
  func start() {
    self.presenter.pushViewController(self.controller, animated: true)
  }
  
  func viewControllerDiDFinish() {
    childCoordinators.removeAll()
    parentCoordinator?.removeChildCoordinator(childCoordinator: self)
  }
  
  func show(_ movie: NetworkMovie) {
    let movieDetailCoordinator = MovieDetailCoordinator(presenter: presenter, movie: movie)
    addChildCoordinator(childCoordinator: movieDetailCoordinator)
    movieDetailCoordinator.parentCoordinator = self
    movieDetailCoordinator.start()
  }
}
