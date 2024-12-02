//
//  MoviesViewModelTests.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import XCTest
@testable import movies

final class MoviesViewModelTests: XCTestCase {
    
    func testListMovies() async {
        // Given
        let sut = makeSUT()
        // When
        sut.fetchMovies()
        // Then
        XCTAssertFalse(sut.movies.isEmpty)
    }
    
    func testSearchMovies() async {
        // Given
        let sut = makeSUT()
        // When
        sut.fetchMovies()
        sut.searchText = "Moana 2"
        // Then
        XCTAssertEqual(sut.filteredMovies.count, 1)
    }
    
    func makeSUT() -> MoviesViewModel {
        MoviesViewModel(moviesService: MoviesServiceMock())
    }

}
