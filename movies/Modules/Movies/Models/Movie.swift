//
//  Movie.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import Foundation

struct MovieResponse: Codable {
    
    let results: [Movie]
    let page: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
    }
    
}

struct Movie: Codable {
    
    let id: Int
    let posterPath: String
    let title: String
    let voteAverage: Double
    let releaseDate: String
    let overview: String
    
    var fullPosterURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
        case overview
    }
    
}
