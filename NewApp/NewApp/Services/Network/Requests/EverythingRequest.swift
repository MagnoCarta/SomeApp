//
//  EverythingRequest.swift
//  NewApp
//
//  Created by Gilberto Magno on 11/05/24.
//

import Foundation

extension Everything.Request: RequestTemplate {
    
    typealias Response = Everything.Response

    var url: URL? {
        var components = Server.v2
        components.path += self.path
        components.queryItems = queryItems
        return components.url
    }
    
    var method: HTTPMethod { .get }

    var path: String { "/everything" }

    var headers: [String: String] { [ "Content-Type": "application/json" ] }
    
    var queryItems: [URLQueryItem] {
        Query.allCases.compactMap {
            if let queryValue = $0.queryValue(for: self) {
                return URLQueryItem(name: $0.rawValue, value: queryValue)
            }
            return nil
        }
        
    }
    
}
