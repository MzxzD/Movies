//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Mateo Doslic on 25/01/2021.
//

import UIKit

class MovieDetailViewController: UIViewController {
  
  var imageView: UIImageView!
  var titleLabel: UILabel!
  var overviewTextView: UITextView!
  var genresTextView: UITextView!
  var stackView: UIStackView!
  var scrollView: UIScrollView!
  var similarButton: UIButton!
  
  var button: UIBarButtonItem!
  
  var movie: NetworkMovie!
  weak var coordinator: MovieDetailCoordinator?
  var isMovieFavorite: Bool = false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    prepareUI()
    
    if let movies = FacadeAPI.shared.getObjectEntityOfType(Movie.self, with: [movie.id!]), movies.count > 0 {
      isMovieFavorite = true
    }
    
    button = UIBarButtonItem(image: UIImage(systemName: isMovieFavorite ? "star.fill" : "star"), style: .done, target: self, action: #selector(starButtonPressed))
    
    self.navigationItem.rightBarButtonItem = button
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    scrollView.contentSize = CGSize(width: stackView.frame.width, height: stackView.frame.height)
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
  
  @objc func starButtonPressed() {
    // remove from favorites
    if isMovieFavorite {
      FacadeAPI.shared.removeEntityOfType(Movie.self, with: movie.id!)
    } else {
      // add to favorites
      FacadeAPI.shared.persistEntity(movie)
    }
    isMovieFavorite = !isMovieFavorite
    button.image = UIImage(systemName: isMovieFavorite ? "star.fill" : "star")
  }
  
  private func prepareUI() {
    self.view.backgroundColor = .white
    scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(scrollView)
    
    scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
    scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    
    stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    scrollView.addSubview(stackView)
    
    stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
    
    let screenBounds = UIScreen.main.bounds
    
    // IMAGE
    imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height / 3))
    stackView.addArrangedSubview(imageView)
    imageView.scalesLargeContentImage = true
    
    imageView.startAnimating()
    if let backdropPath = movie.backdropPath {
      FacadeAPI.shared.fetchImage(.image(.backDrop(path: backdropPath))) { [unowned self] (imageData) in
        if let image = imageData.data {
          imageView.stopAnimating()
          imageView.image = image
        }
      }
    } else {
      imageView.stopAnimating()
    }
    
    // TITLE
    titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: 50))
    titleLabel.font = .systemFont(ofSize: 35)
    titleLabel.textAlignment = .justified
    titleLabel.text = movie.title ?? "N/A"
    stackView.addArrangedSubview(titleLabel)
    
    // Description
    
    let overviewLabel = UILabel(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: 50))
    overviewLabel.font = .systemFont(ofSize: 30)
    overviewLabel.textAlignment = .justified
    overviewLabel.text = "Overview:"
    stackView.addArrangedSubview(overviewLabel)
    
    overviewTextView = UITextView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: 60))
    overviewTextView.isUserInteractionEnabled = false
    
    overviewTextView.font = .systemFont(ofSize: 25)
    overviewTextView.textAlignment = .left
    overviewTextView.textContainer.lineBreakMode = .byWordWrapping
    overviewTextView.text = movie.overview!
    overviewTextView.isScrollEnabled = false
    stackView.addArrangedSubview(overviewTextView)
    
    overviewTextView.translatesAutoresizingMaskIntoConstraints = false
    overviewTextView.widthAnchor.constraint(equalToConstant: screenBounds.width).isActive = true
    
    if let genreIds = movie.genreIDS, let genres = FacadeAPI.shared.getObjectEntityOfType(Genre.self, with: genreIds), genres.count > 0 {
      
      // Genres
      let genresLabels = UILabel(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: 50))
      genresLabels.font = .systemFont(ofSize: 30)
      genresLabels.textAlignment = .justified
      genresLabels.text = "Genres:"
      stackView.addArrangedSubview(genresLabels)
      
      genresTextView = UITextView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: 60))
      genresTextView.isUserInteractionEnabled = false
      let genreText: String = {
        var text = ""
        for genre in genres {
          text.append(genre.name!)
          text.append("\n")
        }
        
        return text
      }()
      genresTextView.font = .systemFont(ofSize: 30)
      genresTextView.textAlignment = .center
      genresTextView.text = genreText
      genresTextView.isScrollEnabled = false
      stackView.addArrangedSubview(genresTextView)
    }
    
    similarButton = UIButton(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: 200))
    similarButton.setTitle("Show similar movies", for: .normal)
    similarButton.addTarget(self, action: #selector(similarButtonPressed), for: .touchUpInside)
    similarButton.translatesAutoresizingMaskIntoConstraints = false
    similarButton.setTitleColor(.black, for: .normal)
    
    stackView.addArrangedSubview(similarButton)
    
  }
  
  @objc func similarButtonPressed() {
    coordinator?.showMovies(using: movie)
  }
  
}
