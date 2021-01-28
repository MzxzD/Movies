//
//  Genres.swift
//  Movies
//
//  Created by Mateo Doslic on 28/01/2021.
//

import Foundation

import Foundation

// MARK: - Genres
struct NetworkGenres: Codable {
    let genres: [NetworkGenre]?
}

// MARK: - Genre
struct NetworkGenre: Codable {
    let id: Int?
    let name: String?
}
