//
//  AppCoordinator.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import UIKit

class AppCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  let window: UIWindow
  var presenter: UINavigationController
  init(window: UIWindow) {
    self.window = window
    presenter = UINavigationController()    
  }
  
  func start() {
    window.makeKeyAndVisible()
    let tabBarCoordinator = TabBarCoordinator(window: window)
    addChildCoordinator(childCoordinator: tabBarCoordinator)
    tabBarCoordinator.start()
    
    // Get all genres and store to persistent store if they Don't exist
    if let genres = FacadeAPI.shared.getObjectEntityOfType(Genre.self){ // genres.count > 0 {
      if genres.count == 0 {
        FacadeAPI.shared.populateGenreToPersistentStore()
      }
    }
  }
}
