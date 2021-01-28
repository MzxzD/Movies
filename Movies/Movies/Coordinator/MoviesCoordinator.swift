//
//  TopMoviesCoordinator.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import UIKit

enum MovesDataType {
  case topMovies
  case popularMovies
  case favoriteMovies
}

class MoviesCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
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
      }
    }()
    self.controller.title = title

  }
  func start() {
    
    switch moviesDataType {
    case .topMovies, .popularMovies:
      let endpoint: Endpoint = {
        if moviesDataType == .topMovies {
          return Endpoint.movie(.topRated)
        } else {
          return Endpoint.movie(.popular)
        }
      }()
      FacadeAPI.shared.fetchEntityType(NetworkMovies.self, from: endpoint) { (wrappedData) in
        if let movies = wrappedData.data {
          let cleanedMovies = movies.results?.compactMap({ (movie) -> NetworkMovie? in
            return (movie.title != nil && movie.posterPath != nil) ? movie : nil
          })
          if let filteredMovies = cleanedMovies {
            self.controller.movies = filteredMovies
          }
        }
        self.presenter.pushViewController(self.controller, animated: true)
      }
      
    case .favoriteMovies:
      // CoreDataImplementation
    ()
    }
  }
}
