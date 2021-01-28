//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import UIKit

class MovieDetailViewController: UIViewController {
  
  var imageView: UIImageView!
  var label: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let imageViewd = UIImageView()
    imageViewd.frame = self.view.bounds
    self.view.addSubview(imageViewd)
    imageView = imageViewd
    imageView.scalesLargeContentImage = true
    
    
    FacadeAPI.shared.fetchEntityType(Genres.self, from: .genre(.list)) { (wrappedData) in
      print(wrappedData)
    }
  }
}

// MARK: - For later
//    let lol = Locale.init(identifier: "en").localizedString(forLanguageCode: "hr")
//    let language = Locale.init(identifier: "hr").localizedString(forLanguageCode: "hr")
//    print(language!) // Arabic (if the user's device language is English)
//    print(lol!)

