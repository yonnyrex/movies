//
//  NetworkService.swift
//  movies
//
//  Created by Yonny on 30/11/24.
//

import Foundation
import Combine
import Moya

protocol NetworkServiceType {
    func execute(request: TargetType) -> AnyPublisher<Data, ServiceError>
}

extension NetworkServiceType {
    func execute<T: Decodable>(
        request: TargetType,
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<T, ServiceError> {
        execute(request: request)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
                ServiceError(message: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}

struct NetworkService: NetworkServiceType {
    // MARK: - Variables
    let provider: MoyaProvider<MultiTarget>
    
    // MARK: - Initializer
    init(provider: MoyaProvider<MultiTarget> = .init()) {
        self.provider = provider
    }
 
    // MARK: - Methods
    func execute(request: TargetType) -> AnyPublisher<Data, ServiceError> {
        Future<Data, Error> { promise in
            self.provider.request(MultiTarget(request)) { response in
                switch response {
                case .success(let result):
                    if Array(200...300).contains(result.statusCode) {
                        promise(.success(result.data))
                    } else {
                        do {
                            let customError = try JSONDecoder().decode(ServiceError.self, from: result.data)
                            promise(.failure(customError))
                        } catch {
                            promise(.failure(
                                ServiceError(
                                    message: "Por favor vuelva a intentarlo",
                                    code: result.statusCode,
                                    success: false
                                )
                            ))
                        }
                    }
                case .failure(let moyaError):
                    do {
                        if let data = moyaError.response?.data {
                            let customError = try JSONDecoder().decode(ServiceError.self, from: data)
                            
                            promise(.failure(customError))
                        } else {
                            promise(.failure(moyaError))
                        }
                    } catch {
                        promise(.failure(moyaError))
                    }
                }
            }
        }
        .mapError { error in
            ServiceError(message: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
}
