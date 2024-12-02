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

extension MovieResponse {
    
    static func getStubMovie() -> Movie {
        Movie(
            id: 1,
            posterPath: "/4YZpsylmjHbqeWzjKpUEF8gcLNW.jpg",
            title: "Moana 2",
            voteAverage: 7.0,
            releaseDate: "2024-11-27",
            overview: "After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she's ever faced."
        )
    }
    
    static func getStubMovies() -> MovieResponse {
        MovieResponse(
            results: [
                Movie(
                    id: 1,
                    posterPath: "/4YZpsylmjHbqeWzjKpUEF8gcLNW.jpg",
                    title: "Moana 2",
                    voteAverage: 7.0,
                    releaseDate: "2024-11-27",
                    overview: "After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she's ever faced."
                ),
                Movie(
                    id: 2,
                    posterPath: "/4YZpsylmjHbqeWzjKpUEF8gcLNW.jpg",
                    title: "Moana 1",
                    voteAverage: 7.0,
                    releaseDate: "2024-11-27",
                    overview: "After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she's ever faced."
                )
            ],
            page: 1,
            totalPages: 2
        )
    }
    
    static func getStubMoviesByName(name: String) -> MovieResponse {
        MovieResponse(
            results: [
                Movie(
                    id: 1,
                    posterPath: "/4YZpsylmjHbqeWzjKpUEF8gcLNW.jpg",
                    title: "Moana 2",
                    voteAverage: 7.0,
                    releaseDate: "2024-11-27",
                    overview: "After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she's ever faced."
                )
            ],
            page: 1,
            totalPages: 2
        )
    }
    
}

