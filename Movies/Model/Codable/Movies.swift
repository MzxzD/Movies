//
//  Movies.swift
//  Movies
//
//  Created by Mateo Doslic on 19/01/2021.
//

import Foundation

// MARK: - Movies
struct NetworkMovies: Codable {
    let page: Int?
    let results: [NetworkMovie]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct NetworkMovie: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Error

struct MoviesError {
  let statusMessage: String?
  let statusCode: Int?
  
  enum CodingKeys: String, CodingKey {
      case statusMessage = "status_message"
      case statusCode = "status_code"
  }
}
