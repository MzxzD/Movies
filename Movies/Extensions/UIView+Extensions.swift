//
//  UIView+Extensions.swift
//  Movies
//
//  Created by Mateo Doslic on 28/01/2021.
//

import UIKit

extension UIView {
  
  func starSpinnerLoading() {
    let loadingIndicator = UIActivityIndicatorView(frame: self.frame)
    self.addSubview(loadingIndicator)
    loadingIndicator.style = UIActivityIndicatorView.Style.large
    loadingIndicator.startAnimating();
  }
  
  
  func stopSpinner() {
    let loadingIndicator = self.subviews.first(where: { $0.isKind(of: UIActivityIndicatorView.self) })
    loadingIndicator?.removeFromSuperview()
  }
}
