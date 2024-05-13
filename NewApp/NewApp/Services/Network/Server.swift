//
//  Server.swift
//  NewApp
//
//  Created by Gilberto Magno on 11/05/24.
//

import Foundation

struct Server {
    static let v2: URLComponents = {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "newsapi.org"
            components.path = "/v2"
            return components
        }()
}
