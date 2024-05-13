//
//  ArticleDataSource.swift
//  NewApp
//
//  Created by Gilberto Magno on 13/05/24.
//

import SwiftData

final class ArticleDataSource {
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = ArticleDataSource()

    @MainActor
    private init() {
        self.modelContainer = try! ModelContainer(for: Article.self)
        self.modelContext = modelContainer.mainContext
    }

    func appendArticle(_ article: Article) {
        modelContext.insert(article)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchArticles(for searchTerm: String) -> Set<Article> {
        do {
            return try Set(modelContext.fetch(FetchDescriptor<Article>()).compactMap { 
                if $0.searchTerm == searchTerm {
                    return $0
                }
                return nil
            })
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func saveArticles(articles: Set<Article>, for searchTerm: String) {
        articles.subtracting(self.fetchArticles(for: searchTerm)).forEach {
            self.appendArticle($0)
        }
    }

    func removeArticle(_ article: Article) {
        modelContext.delete(article)
    }
}
