//
//  AppCoordinator.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import UIKit

class AppCoordinator: Coordinator{  
  
  var childCoordinators: [Coordinator] = []
  let window: UIWindow
  var presenter: UINavigationController
  init(window: UIWindow) {
    self.window = window
    presenter = UINavigationController()
//    window.rootViewController = presenter
    
  }
  
  func start() {
//    window.rootViewController
    window.makeKeyAndVisible()
    let tabBarCoordinator = TabBarCoordinator(window: window)
    addChildCoordinator(childCoordinator: tabBarCoordinator)
    tabBarCoordinator.start()
  }
}
