//
//  MovieDetailViewModel.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import Foundation
import Combine
import Stinsen
import SwiftUI

class MovieDetailViewModel: ObservableObject {
    
    // MARK: - Propety Wrappers
    @RouterObject var router: AuthenticatedCoordinator.Router?
    @Published var error: MoviesError?
    @Published var isLoading = false
    @Published var displayError = false
    @Published var movie: Movie?

    // MARK: - Variables
    private var moviesService: MoviesServiceType
    private var cancellables: Set<AnyCancellable> = .init()
    private var userDefaults: PersistenceServiceType
    private var movieID = ""
    
    // MARK: - Initializer
    init(
        moviesService: MoviesServiceType = MoviesService(),
        userDefaults: PersistenceServiceType = UserDefaultsService(),
        movieID: String
    ) {
        self.moviesService = moviesService
        self.userDefaults = userDefaults
        self.movieID = movieID
        setupBindings()
        loadMovie()
    }
    
    // MARK: - Methods
    func setupBindings() {
        $error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                guard error != nil else { return }
                self?.displayError = true
            }
            .store(in: &cancellables)
    }
    
    func loadMovie() {
        moviesService
            .getMovieDetail(id: movieID)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                self?.isLoading = false
                switch result {
                case .failure(let error):
                    self?.error = .error(message: error.message)
                case .finished:
                    return
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                movie = response
            }
            .store(in: &cancellables)
    }
    
    func popLast() {
        router?.popLast()
    }
    
}
