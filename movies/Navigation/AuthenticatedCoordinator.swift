//
//  AuthenticatedCoordinator.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import SwiftUI
import Stinsen

final class AuthenticatedCoordinator: NavigationCoordinatable {
    
    // MARK: - NavigationStack
    let stack = NavigationStack(initial: \AuthenticatedCoordinator.start, false)
    
    // MARK: - Root Definition
    @Root var start = makeStart
    
    // MARK: - Public Methods
    @ViewBuilder
    func makeStart() -> some View {
        MoviesView()
    }
    
}
