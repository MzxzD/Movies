//
//  Genre+CoreDataProperties.swift
//  Movies
//
//  Created by Mateo Doslic on 28/01/2021.
//
//

import Foundation
import CoreData


extension Genre {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Genre> {
        return NSFetchRequest<Genre>(entityName: "Genre")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var movies: NSSet?

}

// MARK: Generated accessors for movies
extension Genre {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movie)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movie)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

extension Genre : Identifiable {

}
