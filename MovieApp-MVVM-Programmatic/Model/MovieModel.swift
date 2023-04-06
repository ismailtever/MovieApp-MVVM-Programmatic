//
//  MovieModel.swift
//  MovieApp-MVVM-Programmatic
//
//  Created by Ismail Tever on 30.03.2023.
//

import Foundation
struct Result: Codable {
    let search: [Search]
    
    enum CodingKeys: String, CodingKey {
        case search = "Search"
    }
}

// MARK: - Search
struct Search: Codable {
    let title: String
    let year: String
    let imdbID: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case poster = "Poster"
    }
}
