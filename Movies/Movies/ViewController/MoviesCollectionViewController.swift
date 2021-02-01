//
//  TopMoviesCollectionViewController.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import UIKit

private let reuseIdentifier = "Cell"

class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var datasource: MovieDataSource!
  weak var coordinator: MoviesCoordinator?
  var containerView: UIView!
  var needsToLoad: Bool = true
  var label: UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.clearsSelectionOnViewWillAppear = false
    self.collectionView!.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
    
    if needsToLoad {
      self.view.starSpinnerLoading()
    } else {
      label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
      label!.textColor = .white
      label!.font = .systemFont(ofSize: 30)
      label!.textAlignment = .center
      label!.text = "No Favorites yet..."
      self.view.addSubview(label!)
      label!.center = self.collectionView.center
    }
  }
  
  override func viewDidAppear(_ animated: Bool) {
    datasource.prepareDataSource { [unowned self] in
      if needsToLoad {
        view.stopSpinner()
      } else {
        if datasource.count() > 0 {
          label?.removeFromSuperview()
        }
      }
      collectionView.reloadData()
    }
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    if parent == nil {
      coordinator?.viewControllerDiDFinish()
    }
  }
  
  deinit {
    print("\(self) deinited")
  }
  
  // MARK: - collectionView
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return datasource.count()
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieCollectionViewCell
    
    cell.setupCell(movie: datasource.movie(at: indexPath))
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = view.frame.width / 2 - 10
    let height = CGFloat(250)
    return CGSize(width: width, height: height)
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    coordinator?.show(datasource.movie(at: indexPath))
  }
}
