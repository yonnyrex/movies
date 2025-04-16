//
//  MovieLocalDataSource.swift
//  movies
//
//  Created by Yonny on 15/04/25.
//

import Foundation
import CoreData

class MovieLocalDataSource {
    
    private let context = CoreDataStack.shared.context

    func saveMovies(_ movies: [Movie]) {
        let context = CoreDataStack.shared.context
        movies.forEach { movie in
            let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", movie.id)
            let existing = (try? context.fetch(request))?.first

            let entity = existing ?? MovieEntity(context: context)
            entity.from(movie: movie, context: context)
        }

        CoreDataStack.shared.saveContext()
    }

    func fetchCachedMovies() -> [Movie] {
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        let result = try? context.fetch(request)
        return result?.map { $0.toMovie() } ?? []
    }

    func deleteAll() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = MovieEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? context.execute(deleteRequest)
    }
    
}
