//
//  TabBarCoordinator.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import Foundation

import UIKit

class TabBarCoordinator: Coordinator { //NSObject, Coordinator, UINavigationControllerDelegate  {
  
  var childCoordinators: [Coordinator] = []
  let controller: MoviesTabBarViewController
  
  init (window: UIWindow){
    let controller = MoviesTabBarViewController()
    self.controller = controller
    window.rootViewController = controller
  }
  
  func start() {
    
    let topMoviesNavigationController = UINavigationController()
//    topMoviesNavigationController.delegate = self
    let topMoviesCoordinator = MoviesCoordinator(presenter: topMoviesNavigationController, moviesDataType: .topMovies)

    topMoviesNavigationController.title = "Top Movies"
    topMoviesNavigationController.tabBarItem = UITabBarItem(title: "Top Movies", image: UIImage(systemName: "film"), selectedImage: nil)
    topMoviesCoordinator.start()
    
    let popularMoviesNavigationController = UINavigationController()
//    popularMoviesNavigationController.delegate = self
    let popularMoviesCoordinator = MoviesCoordinator(presenter: popularMoviesNavigationController, moviesDataType: .popularMovies)
    
    popularMoviesNavigationController.title = "Popular Movies"
    popularMoviesNavigationController.tabBarItem = UITabBarItem(title: "Popular Movies", image: UIImage(systemName: "film"), selectedImage: nil)
    popularMoviesCoordinator.start()
    
    let favoriteMoviesNavigationController = UINavigationController()
    //    favoriteMoviesNavigationController.delegate = self
    let favoriteMoviesCoordinator = MoviesCoordinator(presenter: favoriteMoviesNavigationController, moviesDataType: .favoriteMovies)
    favoriteMoviesNavigationController.title = "Favorite Movies"
    favoriteMoviesNavigationController.tabBarItem = UITabBarItem(title: "Favorite Movies", image: UIImage(systemName: "star.fill"), selectedImage: nil)
    favoriteMoviesCoordinator.start()
    
    childCoordinators.append(topMoviesCoordinator)
    childCoordinators.append(popularMoviesCoordinator)
    childCoordinators.append(favoriteMoviesCoordinator)
    controller.viewControllers = [topMoviesNavigationController, popularMoviesNavigationController, favoriteMoviesNavigationController]
    
  }
  
//  func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//    guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
//      return
//    }
//    if navigationController.viewControllers.contains(fromViewController) {
//      return
//    }
//
//
//  }
  
}
