//
//  BaseURL.swift
//  NewApp
//
//  Created by Gilberto Magno on 11/05/24.
//

import Foundation

struct BaseURL {
    static let components: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2"
        return components
    }()
    
    static let swaggerComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "swagger.homero.app.br"
        components.port = 8083
        return components
    }()
}
