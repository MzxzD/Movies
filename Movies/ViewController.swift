//
//  ViewController.swift
//  Movies
//
//  Created by Mateo Doslic on 18/01/2021.
//

import UIKit

class ViewController: UIViewController { //, URLSessionDownloadDelegate, URLSessionDelegate {
  var imageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let imageViewd = UIImageView()
    imageViewd.frame = self.view.bounds
    self.view.addSubview(imageViewd)
    imageView = imageViewd
    imageView.scalesLargeContentImage = true
    
    FacadeAPI.shared.fetchEntityType(Movies.self, from: .movie(.popular)) { (wrappedData) in
      let lol = wrappedData.data!.results!.map({
        return $0.posterPath
      })
      for loldd in lol {
        if let lold = loldd {
          FacadeAPI.shared.fetchImage(.image(.poster(path: lold))) { [unowned self] (wrappedImage) in
            if let image = wrappedImage.data {
              self.imageView.image = image
              let color = image.averageColor
              let inverse = color?.textColor()
              print(color)
              print(inverse)
            } else {
              FacadeAPI.shared.showAlertView(from: self, with: "Whoops", and: wrappedImage.error ?? "Something went Wrong")
            }
          }
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

