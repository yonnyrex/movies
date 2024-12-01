//
//  MoviesService.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import Foundation
import Combine

protocol MoviesServiceType {

    func getMovies(page: Int) -> AnyPublisher<MovieResponse, ServiceError>
    func getMovieDetail(id: String) -> AnyPublisher<Movie, ServiceError>
    
}

struct MoviesService: MoviesServiceType {

    // MARK: - Variables
    private let provider: NetworkServiceType
    
    // MARK: - Initializer
    init(provider: NetworkServiceType = NetworkService()) {
        self.provider = provider
    }

    // MARK: - Methods
    func getMovies(page: Int) -> AnyPublisher<MovieResponse, ServiceError> {
        provider.execute(
            request: MoviesAPI.movies(page: page)
        )
    }
    
    func getMovieDetail(id: String) -> AnyPublisher<Movie, ServiceError> {
        provider.execute(
            request: MoviesAPI.movieDetail(id: id)
        )
    }

}
