//
//  Codable+Extensions.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import Foundation
import OSLog

extension Encodable {
    func toData() -> Data? {
        let jsonEncoder = JSONEncoder()
        
        var data: Data?
        
        do {
            data = try jsonEncoder.encode(self)
        } catch let error {
            Logger().error("\(error)")
        }
        
        return data
    }
}
