//
//  MovieEntity.swift
//  movies
//
//  Created by Yonny on 15/04/25.
//

import CoreData

@objc(MovieEntity)
public class MovieEntity: NSManagedObject {}

extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var title: String
    @NSManaged public var posterPath: String
    @NSManaged public var voteAverage: Double
    @NSManaged public var releaseDate: String
    @NSManaged public var overview: String
    @NSManaged public var imageData: Data
}

extension MovieEntity {
    
    func toMovie() -> Movie {
        return Movie(
            id: Int(id),
            posterPath: posterPath,
            title: title,
            voteAverage: voteAverage,
            releaseDate: releaseDate,
            overview: overview,
            imageData: imageData
        )
    }

    func from(movie: Movie, context: NSManagedObjectContext) {
        self.id = Int64(movie.id)
        self.posterPath = movie.posterPath ?? ""
        self.title = movie.title
        self.voteAverage = movie.voteAverage
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
        
        
        // Descarga y guarda imagen si hay conexión
        if let url = movie.fullPosterURL, NetworkMonitor.shared.isConnected {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.imageData = data
                    try? context.save()
                }
            }.resume()
        }
    }
    
}
