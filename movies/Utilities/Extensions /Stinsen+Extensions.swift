//
//  Stinsen+Extensions.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import Foundation
import Stinsen

extension NavigationCoordinatable {
    
    func eraseToNavigationCoordinator() -> NavigationViewCoordinator<Self> {
        return NavigationViewCoordinator(self)
    }
    
}
