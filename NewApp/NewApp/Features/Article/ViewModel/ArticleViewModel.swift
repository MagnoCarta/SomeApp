//
//  ArticleViewModel.swift
//  NewApp
//
//  Created by Gilberto Magno on 11/05/24.
//

import Foundation
import SwiftUI

protocol ArticleViewModelProtocol {
    
}

@Observable
class ArticleViewModel: ArticleViewModelProtocol {
    
    var article: Article
    var articles: [Article]
    var articleImage: Image
    var actualIndex: Int = 0
    
    init(article: Article,
         articles: [Article],
         articleImage: Image? = nil) {
        self.article = article
        if let articleImage = articleImage {
            self.articleImage = articleImage
        } else {
            self.articleImage = Cache.getImage(for: article)
        }
        self.articles = articles
        self.actualIndex = self.actualIndexArticle()
    }
    
    private func actualIndexArticle() -> Int {
        var actualIndex = 0
        for article in self.articles {
            if article == self.article {
                break
            }
            actualIndex += 1
        }
        return actualIndex
    }
    
}
