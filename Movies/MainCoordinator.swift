//
//  MainCoordinator.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import Foundation

import UIKit

class MainCoordinator: BaseCoordinator {
  
  var childCoordinators: [Coordinator] = []
  let controller: MoviesTabBarViewController
  
  init (window: UIWindow){
    window.makeKeyAndVisible()
    controller = MoviesTabBarViewController()
    controller.coordinator = self
    window.rootViewController = controller
  }
  
  deinit {
    print("\(self) deinited")
  }
  
  func start() {
    
    let topMoviesNavigationController = UINavigationController()
    let topMoviesCoordinator = MoviesCoordinator(presenter: topMoviesNavigationController, moviesDataType: .topMovies)
    
    topMoviesNavigationController.title = "Top Movies"
    topMoviesNavigationController.tabBarItem = UITabBarItem(title: "Top Movies", image: UIImage(systemName: "film"), selectedImage: nil)
    topMoviesCoordinator.start()
    
    let popularMoviesNavigationController = UINavigationController()
    let popularMoviesCoordinator = MoviesCoordinator(presenter: popularMoviesNavigationController, moviesDataType: .popularMovies)
    
    popularMoviesNavigationController.title = "Popular Movies"
    popularMoviesNavigationController.tabBarItem = UITabBarItem(title: "Popular Movies", image: UIImage(systemName: "film"), selectedImage: nil)
    popularMoviesCoordinator.start()
    
    let favoriteMoviesNavigationController = UINavigationController()
    let favoriteMoviesCoordinator = MoviesCoordinator(presenter: favoriteMoviesNavigationController, moviesDataType: .favoriteMovies)
    favoriteMoviesNavigationController.title = "Favorite Movies"
    favoriteMoviesNavigationController.tabBarItem = UITabBarItem(title: "Favorite Movies", image: UIImage(systemName: "star.fill"), selectedImage: nil)
    favoriteMoviesCoordinator.start()
    
    addChildCoordinator(childCoordinator: topMoviesCoordinator)
    addChildCoordinator(childCoordinator: popularMoviesCoordinator)
    addChildCoordinator(childCoordinator: favoriteMoviesCoordinator)
    controller.viewControllers = [topMoviesNavigationController, popularMoviesNavigationController, favoriteMoviesNavigationController]
    
    // Get all genres and store to persistent store if they Don't exist
    if let genres = FacadeAPI.shared.getObjectEntityOfType(Genre.self){ // genres.count > 0 {
      if genres.count == 0 {
        FacadeAPI.shared.populateGenreToPersistentStore()
      }
    }
  }
  
  func removeAllChildren(for item: UITabBarItem) {
    guard let coordinator = childCoordinators.first(where: { $0.presenter.tabBarItem == item }) else {
      return
    }
    coordinator.childCoordinators.forEach { (coord) in
      coordinator.removeChildCoordinator(childCoordinator: coord)
    }
  }
  
  
}
