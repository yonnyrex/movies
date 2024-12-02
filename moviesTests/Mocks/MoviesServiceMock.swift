//
//  MoviesServiceMock.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

@testable import movies
import Combine

struct MoviesServiceMock: MoviesServiceType {
    
    func getMovies(page: Int) -> AnyPublisher<MovieResponse, ServiceError> {
        let movies = MovieResponse.getStubMovies()
        return Just(movies).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
    
    func getMovieDetail(id: String) -> AnyPublisher<Movie, ServiceError> {
        let movie = MovieResponse.getStubMovie()
        return Just(movie).setFailureType(to: ServiceError.self).eraseToAnyPublisher()
    }
    
}
