//
//  Endpoint.swift
//  Movies
//
//  Created by Mateo Doslic on 21/01/2021.
//

import Foundation

enum Endpoint {
  
  enum Movie {
    case topRated
    case popular
    case specificMovie(id: Int)
    case similar(id: Int)
  }
  
  enum Genre {
    case list
  }
  
  enum Image {
    case poster(path: String)// = "poster_path"
    case backDrop(path: String)// = "backdrop_path"
  }
  
  case movie(Movie)
  case image(Image)
  case genre(Genre)
  
  func getUrl() -> URL? {
    var baseUrl = ""
    var endpointUrl: String?
    switch self {
    case .movie(let movie):
      baseUrl = "https://api.themoviedb.org/3/movie"
      
      switch movie {
      case .topRated:
        endpointUrl = "/top_rated"
      case .popular:
        endpointUrl = "/popular"
      case .specificMovie(id: let id):
        endpointUrl = "/\(id)"
      case .similar(id: let id):
        endpointUrl = "/\(id)/similar"
      }
    case .image(let image):
      baseUrl = "https://image.tmdb.org/t/p/w400"
      
      switch image {
      case .poster(path: let path):
        endpointUrl = "/\(path)"
      case .backDrop(path: let path):
        endpointUrl = "/\(path)"
      }
    case .genre(let genre):
      baseUrl = "https://api.themoviedb.org/3/"
      
      switch genre {
      case .list:
        endpointUrl = "genre/movie/list"
      }
    }
    
    let urlString: String = {
      var url = baseUrl
      if let endpoint = endpointUrl {
        url.append(endpoint)
      }
      return url
    }()
    return URL(string: urlString)
  }
  
  func queryItems(pageNumber: Int? = nil) -> [String: String] {
    var items: [String: String] = [:]
    items["api_key"] = "fe3b8cf16d78a0e23f0c509d8c37caad"
    if let pageNo = pageNumber {
      items["page"] = "\(pageNo)"
    }
    return items
  }
}
