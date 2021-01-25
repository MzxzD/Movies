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
    let topMoviesCoordinator = TopMoviesCoordinator(presenter: topMoviesNavigationController)
    let topMoviesViewController = topMoviesNavigationController
    topMoviesViewController.tabBarItem = UITabBarItem(title: "Top Movies", image: nil, selectedImage: nil)
    topMoviesCoordinator.start()
    
    
    childCoordinators.append(movieDetailCoordinator)
    childCoordinators.append(topMoviesCoordinator)
    controller.viewControllers = [topMoviesViewController, movieDetailViewController]
    
  }
}
