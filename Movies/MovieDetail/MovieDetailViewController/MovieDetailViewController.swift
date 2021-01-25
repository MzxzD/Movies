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
    
    FacadeAPI.shared.fetchEntityType(Movies.self, from: .movie(.popular)) { (wrappedData) in
      let testInfos: [(path: String, label: String)] = wrappedData.data!.results!.compactMap({
        if let poster = $0.posterPath, let title = $0.title {
          return (path: poster, label: title )
        } else {
          return nil
        }
      })
      let firstInfo = testInfos.first!
      
      
      FacadeAPI.shared.fetchImage(.image(.poster(path: firstInfo.path))) { [unowned self] (wrappedImage) in
        if let image = wrappedImage.data {
          self.imageView.image = image
          let color = image.averageColor
          let inverse = color?.textColor()
        } else {
          FacadeAPI.shared.showAlertView(from: self, with: "Whoops", and: wrappedImage.error ?? "Something went Wrong")
        }
      }
      
    }
  }
}

// MARK: - For later
//    let lol = Locale.init(identifier: "en").localizedString(forLanguageCode: "hr")
//    let language = Locale.init(identifier: "hr").localizedString(forLanguageCode: "hr")
//    print(language!) // Arabic (if the user's device language is English)
//    print(lol!)

