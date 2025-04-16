//
//  NetworkMonitor.swift
//  movies
//
//  Created by Yonny on 15/04/25.
//

import Network

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private(set) var isConnected = true

    init() {
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        monitor.start(queue: DispatchQueue(label: "NetworkMonitor"))
    }
    
}
