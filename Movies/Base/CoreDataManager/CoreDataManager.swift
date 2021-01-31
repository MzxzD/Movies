//
//  CoreDataManager.swift
//  Movies
//
//  Created by Mateo Doslic on 28/01/2021.
//
import CoreData
import UIKit


class CoreDataManager {
    
  func getObjectEntityOfType<T: NSManagedObject>(_ type: T.Type, with ids: [Int]? = nil) -> [T]? {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
    else {
      fatalError("Could not get app delegate instance!")
    }
    let mainManagedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = T.fetchRequest()
    if let ids = ids {
      var predicates: [NSPredicate] = []
      for id in ids {
        let predicate = NSPredicate(format: "id = %d", id)
        predicates.append(predicate)
      }
      fetchRequest.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
    }
    do {
      if let objects = try mainManagedContext.fetch(fetchRequest) as? [T] {
        return objects
      } else {
        return nil
      }
    } catch {
      return nil
    }
  }
  
  func castToPersistable(_ source: NetworkMovie) -> Movie {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
    else {
      fatalError("Could not get app delegate instance!")
    }
    let mainManagedContext = appDelegate.persistentContainer.viewContext
    let movie = Movie(context: mainManagedContext)
    movie.adult = source.adult ?? false
    movie.backdropPath = source.backdropPath
    movie.id = Int32(source.id ?? 0)
    movie.originalLanguage = source.originalLanguage
    movie.originalTitle = source.originalTitle
    movie.overview = source.overview
    movie.popularity = source.popularity ?? 0.0
    movie.posterPath = source.posterPath
    movie.releaseDate = source.releaseDate
    movie.title = source.title
    movie.voteAverage = source.voteAverage ?? 0
    movie.voteCount = Int32(source.voteCount ?? 0)
    
    if let genres = getObjectEntityOfType(Genre.self, with: source.genreIDS) {
      for genre in genres {
        movie.addToGenres(genre)
      }
    }
    return movie
  }
  
  func castToPersistable(_ source: NetworkGenre) -> Genre {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
    else {
      fatalError("Could not get app delegate instance!")
    }
    let mainManagedContext = appDelegate.persistentContainer.viewContext
    let genre = Genre(context: mainManagedContext)
    genre.id = Int32(source.id ?? 0)
    genre.name = source.name
    return genre
  }
  
  func populateGenreToPersistentStore() {
    FacadeAPI.shared.fetchEntityType(NetworkGenres.self, from: .genre(.list)) { (wrappedData) in
      if let genresData = wrappedData.data, let genres = genresData.genres {
        let filteredGenres = genres.compactMap { (genre) -> NetworkGenre? in
          return (genre.id != nil && genre.name != nil) ? genre : nil
        }
        var genres: [Genre] = []
        for genre in filteredGenres {
          let persistableGenre = self.castToPersistable(genre)
          genres.append(persistableGenre)
        }
        self.saveContext()
      }
    }
  }
  
  private func saveContext() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
    else {
      fatalError("Could not get app delegate instance!")
    }
    let mainManagedContext = appDelegate.persistentContainer.viewContext
    
    do {
      try mainManagedContext.save()
    } catch {
      print(error)
    }
  }
  
  func removeEntityOfType<T: NSManagedObject>(_ type: T.Type, with id: Int) {
    // Since it's not multiContext app, I can do this
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
    else {
      fatalError("Could not get app delegate instance!")
    }
    let mainManagedContext = appDelegate.persistentContainer.viewContext
    
    let objects = self.getObjectEntityOfType(type, with: [id])
    for object in objects! {
      mainManagedContext.delete(object)
    }
    saveContext()
  }
  
  func persistEntity(_ movie: NetworkMovie) {
    _ = self.castToPersistable(movie)
    saveContext()
  }
  
}



