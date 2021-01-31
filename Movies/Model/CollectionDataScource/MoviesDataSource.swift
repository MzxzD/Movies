//
//  MoviesDataSource.swift
//  Movies
//
//  Created by Mateo Doslic on 31/01/2021.
//

import Foundation

enum MovesDataType: Equatable {
  case topMovies
  case popularMovies
  case favoriteMovies
  case similar(NetworkMovie)
  
  static func == (lhs: MovesDataType, rhs: MovesDataType) -> Bool {
    switch (lhs, rhs) {
    case (.topMovies, .topMovies):
      return true
    case (.popularMovies, .popularMovies):
      return true
    case (.favoriteMovies, .favoriteMovies):
      return true
    case (.similar(let lhsMovie), .similar(let rhsMovie)):
      return lhsMovie.id == rhsMovie.id
    default:
      return false
    }
  }
}


class MovieDataSource {
  
  private var persistableMovie: [Movie] = []
  private var codableMovies: [NetworkMovie] = []
  private let dataType: MovesDataType
  private var datasourceCompletion: (() -> ())?
  
  init(movieDataType: MovesDataType) {
    dataType = movieDataType
  }
  
  func count() -> Int {
    switch dataType {
    case .popularMovies, .similar(_), .topMovies:
      return codableMovies.count
    case .favoriteMovies:
      return persistableMovie.count
    }
  }
  
  func movie(at indexPath: IndexPath) -> NetworkMovie {
    switch dataType {
    case .popularMovies, .similar(_), .topMovies:
      return codableMovies[indexPath.row]
    case .favoriteMovies:
      return persistableMovie[indexPath.row].castToCodable()
    }
  }
  
  func prepareDataSource(completion: @escaping () -> ()) {
    self.datasourceCompletion = completion
    switch dataType {
    case .topMovies:
      prepareCodableDatasource(from: .movie(.topRated))
    case .popularMovies:
      prepareCodableDatasource(from: .movie(.popular))
    case .favoriteMovies:
      persistableMovie = FacadeAPI.shared.getObjectEntityOfType(Movie.self)!
      self.datasourceCompletion!()
    case .similar(let movie):
      prepareCodableDatasource(from: .movie(.similar(id: movie.id!)))
    }
  }
  
  private func prepareCodableDatasource(from endpoint: Endpoint) {
    FacadeAPI.shared.fetchEntityType(NetworkMovies.self, from: endpoint) { [unowned self] (wrappedData) in
      if let movies = wrappedData.data {
        let cleanedMovies = movies.results?.compactMap({ (movie) -> NetworkMovie? in
          return (movie.title != nil && movie.posterPath != nil) ? movie : nil
        })
        if let filteredMovies = cleanedMovies {
          codableMovies = filteredMovies
          datasourceCompletion!()
        }
      }
    }
  }
}
