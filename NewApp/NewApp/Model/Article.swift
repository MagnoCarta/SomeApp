//
//  Article.swift
//  NewApp
//
//  Created by Gilberto Magno on 11/05/24.
//

import Foundation
import SwiftData

struct Source: Codable {
    let id, name: String?
}

extension Source: Hashable {}

struct ArticleData: Codable {
    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    var isFavorite: Bool? = false
    var shadowBlock: Bool? = false
    
    func decode() -> Article {
        Article(self)
    }
    
}

@Model
class Article {
    
    let source: Source?
    let author: String?
    let title: String?
    let summary: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    var isFavorite: Bool?
    var shadowBlock: Bool?
    
    init(source: Source? = nil,
         author: String? = nil ,
         title: String? = nil,
         summary: String? = nil,
         url: String? = nil,
         urlToImage: String? = nil,
         publishedAt: String? = nil,
         content: String? = nil,
         isFavorite: Bool? = false,
         shadowBlock: Bool? = false) {
        self.source = source
        self.author = author
        self.title = title
        self.summary = summary
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
        self.isFavorite = isFavorite
        self.shadowBlock = shadowBlock
    }
    
    init(_ articleData: ArticleData) {
        self.source = articleData.source
        self.author = articleData.author
        self.title = articleData.title
        self.summary = articleData.description
        self.url = articleData.url
        self.urlToImage = articleData.urlToImage
        self.publishedAt = articleData.publishedAt
        self.content = articleData.content
        self.isFavorite = articleData.isFavorite
        self.shadowBlock = articleData.shadowBlock
    }
    
}

extension Article: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.title)
    }
    
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.title == rhs.title
    }
}
