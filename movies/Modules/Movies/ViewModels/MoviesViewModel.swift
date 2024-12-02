//
//  MoviesViewModel.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import Foundation
import Combine
import Stinsen
import SwiftUI

class MoviesViewModel: ObservableObject {
    
    // MARK: - Propety Wrappers
    @RouterObject var router: AuthenticatedCoordinator.Router?
    @Published var error: MoviesError?
    @Published var isLoading = false
    @Published var displayError = false
    @Published var searchText = ""
    @Published var movies: [Movie] = []
    @Published var filteredMovies: [Movie] = []

    // MARK: - Variables
    private var moviesService: MoviesServiceType
    private var cancellables: Set<AnyCancellable> = .init()
    private var userDefaults: PersistenceServiceType
    private var currentPage = 1
    private var totalPages = 1
    private var isDelaying = false
    
    // MARK: - Constants
    let itemsPerPage = 20
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    // MARK: - Initializer
    init(
        moviesService: MoviesServiceType = MoviesService(),
        userDefaults: PersistenceServiceType = UserDefaultsService()
    ) {
        self.moviesService = moviesService
        self.userDefaults = userDefaults
        setupBindings()
        //fetchMovies()
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
        $searchText
            .combineLatest($movies)
            .map { searchText, movies in
                guard !searchText.isEmpty else { return movies }
                return movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            }
            .assign(to: &$filteredMovies)
    }
    
    func fetchMovies() {
        guard currentPage <= totalPages else { return }
        moviesService
            .getMovies(page: currentPage)
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
                movies.append(contentsOf: response.results)
                totalPages = response.totalPages
                currentPage += 1
            }
            .store(in: &cancellables)
    }
    
    func loadMoreMoviesIfNeeded(currentItem: Movie?) {
        guard let currentItem = currentItem else { return }
        let thresholdIndex = movies.index(movies.endIndex, offsetBy: -5)
        if let currentIndex = movies.firstIndex(where: { $0.id == currentItem.id }),
           currentIndex >= thresholdIndex,
           !isLoading {
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.fetchMovies()
            }
        }
    }
    
    func goToMovieDetail(movieID: String) {
        self.router?.route(to: \.movieDetail, movieID)
    }
    
}
