//
//  MovieDetailView.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import SwiftUI

struct MovieDetailView: View {
 
    // MARK: - PropertyWrappers
    @ObservedObject private var viewModel: MovieDetailViewModel

    init(
        viewModel: MovieDetailViewModel = MovieDetailViewModel(movieID: "")
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 30) {
            navigationBar
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    VStack(alignment: .leading, spacing: 16) {
                        poster
                        VStack(alignment: .leading, spacing: 12) {
                            title
                            rating
                            releaseDate
                            overview
                        }
                        .frame(maxWidth: .greatestFiniteMagnitude, alignment: .leading)
                        .padding(16)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 4)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
        .toolbar(.hidden)
    }
    
    var photo: some View {
        AsyncImage(url: viewModel.movie?.fullPosterURL) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 120, height: 200)
                .cornerRadius(8)
        } placeholder: {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(width: 120, height: 200)
                .cornerRadius(8)
        }
    }
    
    var poster: some View {
        ZStack {
            AsyncImage(url: viewModel.movie?.fullPosterURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 200)
                    .clipped()
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 120, height: 200)
            }
        }
        .cornerRadius(12)
        .shadow(radius: 4)
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    var title: some View {
        Text(viewModel.movie?.title ?? "")
            .font(.title2)
            .fontWeight(.semibold)
            .multilineTextAlignment(.leading)
    }
    
    var rating: some View {
        HStack(spacing: 8) {
            Image(systemName: "star.fill")
                .foregroundColor(.yellow)
            Text(String(format: "%.1f", viewModel.movie?.voteAverage ?? 0.0))
                .font(.headline)
        }
    }
    
    var releaseDate: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Fecha de lanzamiento:")
                .font(.caption)
                .foregroundColor(.secondary)
            Text(viewModel.movie?.releaseDate ?? "N/A")
                .font(.subheadline)
        }
    }
    
    var overview: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Resumen de la película:")
                .font(.headline)
            Text(viewModel.movie?.overview ?? "No description available.")
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
    
    var navigationBar: some View {
        ZStack {
            HStack {
                Button {
                    viewModel.popLast()
                } label: {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                Spacer()
            }
            Text("Descripcion")
                .font(.title2)
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 20)
        .frame(height: 58.0)
    }
    
}

#Preview {
    MovieDetailView()
}
