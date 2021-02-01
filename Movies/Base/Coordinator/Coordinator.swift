//
//  Coordinator.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import UIKit

public protocol BaseCoordinator: AnyObject {
  var childCoordinators: [Coordinator] { get set }
  func start()

}

public protocol Coordinator: BaseCoordinator {
  var presenter: UINavigationController { get set }
}

public extension BaseCoordinator {
  
  /// Add a child coordinator to the parent
  func addChildCoordinator(childCoordinator: Coordinator) {
    self.childCoordinators.append(childCoordinator)
  }
  
  /// Remove a child coordinator from the parent
  func removeChildCoordinator(childCoordinator: Coordinator) {
    self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
  }
  
}
