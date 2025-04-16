//
//  UserDefaultsService.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import Foundation

class UserDefaultsService: PersistenceServiceType {
    
    // MARK: - PersistanceServiceType Protocol
    func save(key: PersistenceKey, value: Any) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func retrieve(for key: PersistenceKey) -> Any? {
        UserDefaults.standard.object(forKey: key.rawValue)
    }
    
    func remove(for key: PersistenceKey) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
}
