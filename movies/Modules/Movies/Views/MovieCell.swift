//
//  MovieCell.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import SwiftUI

struct MovieCell: View {
    
    let movie: Movie
    
    var body: some View {
        VStack {
            image
            title
        }
        .frame(width: 150)
    }
    
    var image: some View {
        AsyncImage(url: movie.fullPosterURL) { image in
            image
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 220)
                .clipped()
                .cornerRadius(12)
                .shadow(radius: 5)
        } placeholder: {
            ZStack {
                Color.gray.opacity(0.3)
                ProgressView()
            }
            .frame(width: 150, height: 220)
            .cornerRadius(12)
            .shadow(radius: 5)
        }
    }
    
    var title: some View {
        Text(movie.title)
            .font(.headline)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .padding(.top, 8)
    }
    
}


#Preview {
    MovieCell(
        movie: Movie(
            id: 1,
            posterPath: "/4YZpsylmjHbqeWzjKpUEF8gcLNW.jpg",
            title: "Moana 2",
            voteAverage: 7.0,
            releaseDate: "2024-11-27",
            overview: "After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she's ever faced."
        )
    )
}
