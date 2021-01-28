//
//  TabBarCoordinator.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import Foundation

import UIKit

class TabBarCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  let controller: MoviesTabBarViewController
  
  init (window: UIWindow){
    let controller = MoviesTabBarViewController()
    self.controller = controller
    window.rootViewController = controller
  }
  
  func start() {
    let movieDetailCoordinator = MovieDetailCoordinator()
    let movieDetailViewController = movieDetailCoordinator.controller
    movieDetailViewController.tabBarItem = UITabBarItem(title: "Detail", image: nil, selectedImage: nil)
    
    let topMoviesNavigationController = UINavigationController()
    let topMoviesCoordinator = MoviesCoordinator(presenter: topMoviesNavigationController, moviesDataType: .topMovies)
//    let topMoviesViewController = topMoviesNavigationController
    topMoviesNavigationController.title = "Top Movies"
    topMoviesNavigationController.tabBarItem = UITabBarItem(title: "Top Movies", image: nil, selectedImage: nil)
    topMoviesCoordinator.start()
    
    let popularMoviesNavigationController = UINavigationController()
    let popularMoviesCoordinator = MoviesCoordinator(presenter: popularMoviesNavigationController, moviesDataType: .popularMovies)
    popularMoviesNavigationController.title = "Popular Movies"
    popularMoviesNavigationController.tabBarItem = UITabBarItem(title: "Popular Movies", image: nil, selectedImage: nil)
    popularMoviesCoordinator.start()
    
    childCoordinators.append(movieDetailCoordinator)
    childCoordinators.append(topMoviesCoordinator)
    controller.viewControllers = [topMoviesNavigationController, popularMoviesNavigationController, movieDetailViewController]
    
  }
}
