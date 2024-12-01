//
//  UnauthenticatedCoordinator.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import SwiftUI
import Stinsen

final class UnauthenticatedCoordinator: NavigationCoordinatable {
    
    // MARK: - NavigationStack
    let stack = NavigationStack(initial: \UnauthenticatedCoordinator.start, false)
    
    // MARK: - Root Definition
    @Root var start = makeStart
    
    // MARK: - Routes
    @Root var authenticated = authenticatedCoordinator

    // MARK: - Public Methods
    @ViewBuilder
    func makeStart() -> some View {
        LoginView()
    }
    
    func authenticatedCoordinator() -> NavigationViewCoordinator<AuthenticatedCoordinator> {
        AuthenticatedCoordinator().eraseToNavigationCoordinator()
    }

}
