//
//  moviesApp.swift
//  movies
//
//  Created by Yonny on 30/11/24.
//

import SwiftUI

@main
struct moviesApp: App {

    let userDefaultsService = UserDefaultsService()

    var body: some Scene {
        WindowGroup {
            if let isLogin = userDefaultsService.retrieve(for: .isLogin) as? Bool, isLogin {
                return AuthenticatedCoordinator().view()
            } else {
                return UnauthenticatedCoordinator().view()
            }
        }
    }
    
}
