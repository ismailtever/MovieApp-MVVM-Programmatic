//
//  MovieDetailModel.swift
//  MovieApp-MVVM-Programmatic
//
//  Created by Ismail Tever on 1.04.2023.
//

import Foundation

// MARK: - DetailResults

struct DetailResults: Codable {
    let title: String
    let year: String
    let released: String
    let runtime: String
    let genre: String
    let director: String
    let writer: String
    let actors: String
    let plot: String
    let awards: String
    let poster: String
    let imdbRating: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case awards = "Awards"
        case poster = "Poster"
        case imdbRating
    
    }
}
