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
    presenter.pushViewController(controller, animated: true)
  }
}
