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
        Set(fetchAllArticles().compactMap {
            if $0.searchTerm == searchTerm {
                return $0
            }
            return nil
        })
    }
    
    func fetchFavoriteArticles() -> Set<Article> {
        Set(fetchAllArticles().compactMap {
            if $0.isFavorite ?? false {
                return $0
            }
            return nil
        })
    }
    
    func fetchFavoriteArticles(for searchTerm: String) -> Set<Article> {
        Set(fetchArticles(for: searchTerm).compactMap {
            if $0.isFavorite ?? false {
                return $0
            }
            return nil
        })
    }
    
    func fetchAllArticles() -> Set<Article> {
        do {
            return try Set(modelContext.fetch(FetchDescriptor<Article>()))
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
