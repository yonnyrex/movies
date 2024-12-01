//
//  MoviesAPI.swift
//  movies
//
//  Created by Yonny on 1/12/24.
//

import Foundation
import Moya

enum MoviesAPI {
    
    case movies(page: Int)
    case movieDetail(id: String)
    
}

extension MoviesAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org" + "/3/")!
    }
    
    var path: String {
        switch self {
        case .movies:
            return "movie/upcoming"
        case .movieDetail(let id):
            return "movie/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .movies, .movieDetail:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .movies(let page):
            let parameters: [String: Any] = [
                "page": page,
                "api_key": MoviesAPI.apiKey
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .movieDetail:
            let parameters: [String: Any] = [
                "api_key": MoviesAPI.apiKey
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String: String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    static var apiKey: String {
        return "f46b58478f489737ad5a4651a4b25079"
    }
    
}
