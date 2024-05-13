//
//  Cache.swift
//  NewApp
//
//  Created by Gilberto Magno on 12/05/24.
//

import Foundation
import SwiftUI

class Cache {
    
    private var articles: Set<Article> = []
    private var articleImageData: [Article : Data] = [:]
    
    private init() {}
    
    static let shared: Cache = .init()
    
    func getCachedArticles() -> Set<Article> {
        articles
    }
    
    func setCachedArticles(articles: Set<Article>) {
        self.articles = articles
        setImageDatas(newArticles: articles)
    }
    
    func appendCachedArticles(_ articles: Set<Article>) {
        self.articles.formUnion(articles)
        setImageDatas(newArticles: articles)
    }
    
    func resetCache() {
        self.articles = []
        self.articleImageData = [:]
    }
    
    private func getImageData(imageURL: String?, completion: @escaping (Data?) -> Void ) {
            if let imageURL = imageURL,
               let url = URL(string: imageURL) {
                NetworkService.shared.request(ImageData.Request(url: url), completion: { result in
                    switch result {
                    case .failure(let error):
                        // ADD LOG :D
                        print(error.localizedDescription)
                    case .success(let data):
                        completion(data)
                    }
                })
            }
            return
    }
    
    private func setImageDatas(newArticles: any Sequence<Article>) {
        newArticles.forEach { article in
            getImageData(imageURL: article.urlToImage) { data in
                self.articleImageData[article] = data
            }
        }
    }
    
    static func getImage(for article: Article, in articleImageData: [Article : Data] = Cache.shared.articleImageData) -> Image {
        guard let data = articleImageData[article],
              let image = UIImage(data: data) else {
            return Image(.no)
        }
        return Image(uiImage: image)
    }
    
    static func isArticleInCache(for article: Article,
                                      instance: Cache = .shared) -> Bool {
        instance.articleImageData[article] != nil
    }

    
}

struct ImageData {
    
    struct Request {
        var url: URL?
        
    }
    
}

extension ImageData.Request: RequestTemplate {
    typealias Response = Data
    

    var path: String { "" }

    var method: HTTPMethod { .get }

    var headers: [String: String] { [ "Content-Type": "application/json" ] }
    
}
