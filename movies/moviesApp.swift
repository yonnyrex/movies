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
            return UnauthenticatedCoordinator().view()
        }
    }
    
}
