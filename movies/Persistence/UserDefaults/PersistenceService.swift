//
//  PersistenceService.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import Foundation

enum PersistenceKey: String, CaseIterable {
    
    case isLogin
    
}

protocol PersistenceServiceType {
    
    func save(key: PersistenceKey, value: Any)
    func retrieve(for key: PersistenceKey) -> Any?
    func remove(for key: PersistenceKey)
    
}
