//
//  MoviesTabBarViewController.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import UIKit

class MoviesTabBarViewController: UITabBarController, UITabBarControllerDelegate {
  
  weak var coordinator: MainCoordinator?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
  }
  
  // If you are deep inside the navigation stack and click the same tabBar you were on, it creates
  // memory leak because i didn't remove propely the references...
  
  // UITabBarDelegate
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
      print("\(item)")
    coordinator?.removeAllChildren(for: item)
  }


  
}
