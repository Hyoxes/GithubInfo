//
//  WebRequest.swift
//  GithubInfo
//
//  Created by Thomas Noble on 27/01/2022.
//

import Foundation
import Combine

enum enum_error_type: Error {
    case parsing(description: String)
    case network(description: String)
}

func webRequest<T>(with url: URL) -> AnyPublisher<T, enum_error_type> where T:Decodable {
    let request  = URLRequest(url: url)
    return URLSession.shared.dataTaskPublisher(for: request)
        .mapError { error in
            enum_error_type.network(description: error.localizedDescription)
        }
        .flatMap(maxPublishers: .max(1)) {response in
            decode(data: response.data)
        }
        .eraseToAnyPublisher()
}

func decode<T>(data: Data) -> AnyPublisher<T, enum_error_type> where T:Decodable
{
    let decoder = JSONDecoder()
    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError{error in
            
            enum_error_type.parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}


