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
    let userDefaultsService = UserDefaultsService()

    // MARK: - Root Definition
    @Root var start = makeStart
    
    // MARK: - Routes
    @Root var authenticated = authenticatedCoordinator

    // MARK: - Public Methods
    @ViewBuilder
    func makeStart() -> some View {
        if let isLogin = userDefaultsService.retrieve(for: .isLogin) as? Bool, isLogin {
            authenticatedCoordinator().view()
        } else {
            LoginView()
        }
    }
    
    func authenticatedCoordinator() -> NavigationViewCoordinator<AuthenticatedCoordinator> {
        AuthenticatedCoordinator().eraseToNavigationCoordinator()
    }

}
