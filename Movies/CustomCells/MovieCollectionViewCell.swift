//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
  static let reuseIdentifier = "MovieCollectionCell"
  var imageView: UIImageView!
  var label: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 20)
    imageView = UIImageView(frame: frame)
    imageView?.backgroundColor = UIColor.black
    contentView.addSubview(imageView!)
    label = UILabel(frame: CGRect(x: 8, y: self.bounds.height - 12, width: self.bounds.width - 20, height: 20))
    label?.textColor = UIColor.white
    contentView.addSubview(label!)
  }
  
  func setupCell(movie: NetworkMovie) {
    starSpinnerLoading()
    label.text = movie.title
    FacadeAPI.shared.fetchImage(.image(.poster(path: movie.posterPath ?? ""))) { [unowned self] (wrappedImage) in
      if let image = wrappedImage.data {
        stopSpinner()
        imageView.image = image
//        let color = image.averageColor
//        let inverse = color?.textColor()
//        label.textColor = inverse
      }
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var bounds: CGRect {
    didSet {
      contentView.frame = bounds
    }
  }
  
}
