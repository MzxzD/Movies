//
//  Genres.swift
//  Movies
//
//  Created by Mateo Doslic on 28/01/2021.
//

import Foundation

import Foundation

// MARK: - Genres
struct Genres: Codable {
    let genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
