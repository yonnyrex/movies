//
//  MoviesView.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import SwiftUI

struct MoviesView: View {
    
    // MARK: - PropertyWrappers
    @ObservedObject private var viewModel: MoviesViewModel

    init(viewModel: MoviesViewModel = MoviesViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 20) {
            searchTextField
            listMovies
        }
        .alert(isPresented: $viewModel.displayError) {
            Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? "Error desconocido"), dismissButton: .default(Text("OK")))
        }
    }
    
    var searchTextField: some View {
        HStack {
            TextField("Buscar películas...", text: $viewModel.searchText)
                .padding(15)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            if !viewModel.searchText.isEmpty {
                Button(action: {
                    viewModel.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal, 27)
        .padding(.top, 10)
    }
    
    var listMovies: some View {
        ScrollView {
            LazyVGrid(columns: viewModel.columns, spacing: 20) {
                ForEach(viewModel.filteredMovies, id: \.id) { movie in
                    MovieCell(movie: movie)
                        .onTapGesture {
                            viewModel.goToMovieDetail(movieID: "\(movie.id)")
                        }
                        .onAppear {
                            viewModel.loadMoreMoviesIfNeeded(currentItem: movie)
                        }
                }
            }
            .padding()
            if viewModel.isLoading {
                HStack {
                    Spacer()
                    VStack(spacing: 10) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                            .scaleEffect(1.5)
                        Text("Cargando más películas...")
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()
                .transition(.opacity)
            }
        }
    }
    
}

#Preview {
    MoviesView()
}
