//
//  Movie+CoreDataClass.swift
//  Movies
//
//  Created by Mateo Doslic on 28/01/2021.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {

  func castToCodable() -> NetworkMovie {
    let genreIds = (self.genres?.allObjects as! [Genre]).map({ Int($0.id) })
    return NetworkMovie(adult: self.adult, backdropPath: self.backdropPath, genreIDS: genreIds, id: Int(self.id), originalLanguage: self.originalLanguage, originalTitle: self.originalTitle, overview: self.overview, popularity: self.popularity, posterPath: self.posterPath, releaseDate: self.releaseDate, title: self.title, video: false, voteAverage: self.voteAverage, voteCount: Int(self.voteCount))
  }
  
}
