//
//  EverythingResponse.swift
//  NewApp
//
//  Created by Gilberto Magno on 11/05/24.
//

import Foundation
struct Everything {
    
    struct Request {
        var apiKey: String = "033040f109fe473b90a210684eba4bbc"
        var searchIn: String
        var sources: String?
        var domains: String?
        var excludeDomains: String?
        var from: String?
        var to: String?
        var language: String?
        var sortBy: String?
        var pageSize: String?
        var page: String?
        
        enum Query: String, CaseIterable {
            case apiKey
            case searchIn = "q"
            case sources
            case domains
            case excludeDomains
            case from
            case to
            case language
            case sortBy
            case pageSize
            case page
            
            func queryValue(for request: Request) -> String? {
                switch self {
                case .apiKey:
                    request.apiKey
                case .searchIn:
                    request.searchIn
                case .sources:
                    request.sources
                case .domains:
                    request.domains
                case .excludeDomains:
                    request.excludeDomains
                case .from:
                    request.from
                case .to:
                    request.to
                case .language:
                    request.language
                case .sortBy:
                    request.sortBy
                case .pageSize:
                    request.pageSize
                case .page:
                    request.page
                }
            }
        }
        
    }
    
    struct Response: Decodable {
        let status: String
        let totalResults: Int
        let articles: [ArticleData]
    }
}

extension Everything.Request: Identifiable, Hashable, Comparable {
    static func < (lhs: Everything.Request, rhs: Everything.Request) -> Bool {
        lhs.searchIn < rhs.searchIn
    }
    
    var id: String {
        var id: String = ""
        self.queryItems.forEach { id += $0.value ?? "" }
        return id
    }
}
