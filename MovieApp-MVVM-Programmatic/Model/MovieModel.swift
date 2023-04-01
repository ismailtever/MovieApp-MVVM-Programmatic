//
//  MovieModel.swift
//  MovieApp-MVVM-Programmatic
//
//  Created by Ismail Tever on 30.03.2023.
//

import Foundation

// MARK: - Movies
struct Movies: Codable {
    let page: Int
    let results: [Result]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Codable {
  
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String?
    let title: String
    let voteAverage: Double
    

    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case voteAverage = "vote_average"
    }
}

