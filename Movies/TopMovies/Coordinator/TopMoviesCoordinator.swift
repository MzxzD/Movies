//
//  TopMoviesCoordinator.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import UIKit

class TopMoviesCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  var presenter: UINavigationController
  let controller: TopMoviesCollectionViewController
  
  init (presenter: UINavigationController){
    self.presenter = presenter
    let flowLayout = UICollectionViewFlowLayout()
    let controller = TopMoviesCollectionViewController(collectionViewLayout: flowLayout)
    self.controller = controller
    controller.title = "Top Movies"
  }
  
  func start() {
    FacadeAPI.shared.fetchEntityType(Movies.self, from: .movie(.topRated)) { (wrappedData) in
      if let movies = wrappedData.data {
        let cleanedMovies = movies.results?.compactMap({ (movie) -> Movie? in
          return (movie.title != nil && movie.posterPath != nil) ? movie : nil
        })
        if let filteredMovies = cleanedMovies {
          self.controller.movies = filteredMovies
        }
      }
      self.presenter.pushViewController(self.controller, animated: true)

    }
    
    
  }
}
