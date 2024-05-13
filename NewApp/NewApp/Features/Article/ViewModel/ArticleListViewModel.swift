//
//  ArticleListViewModel.swift
//  NewApp
//
//  Created by Gilberto Magno on 11/05/24.
//

import SwiftUI
import SwiftData

protocol ArticleListViewModelProtocol {
    var filteredArticles: [Article] { get }
    var request: Everything.Request { get set }
    var isPresentingAlert: Bool { get set }
    var searchText: String { get set }
    
    func sortBy(_ sort: String)
    func setNextPageNeeds(article: Article)
}

@Observable
class ArticleListViewModel: ArticleListViewModelProtocol {
    
    private var networkManager: NetworkServiceInterface
    @ObservationIgnored private let dataSource: ArticleDataSource?
    private let cache: Cache?
    
    private var articles: Set<Article> = [] {
        didSet {
            cache?.appendCachedArticles(articles)
        }
    }
    var sortedArticles: [Article] {
        self.sort(articles)
    }
    var filteredArticles: [Article] {
        filterArticles(searchText, sortedArticles)
    }
    
    var request: Everything.Request
    var searchText: String = ""
    var isPresentingAlert: Bool
    
    init(articles: Set<Article> = [],
         networkManager: NetworkServiceInterface = NetworkService.shared,
         request: Everything.Request = .init(apiKey: "033040f109fe473b90a210684eba4bbc",
                                             searchIn: "a",
                                             pageSize: "10",
                                             page: "1"),
         isPresentingAlert: Bool = false,
         searchText: String = "",
         dataSource: ArticleDataSource? = ArticleDataSource.shared,
         cache: Cache? = Cache.shared) {
        self.articles = articles
        self.networkManager = networkManager
        self.request = request
        self.isPresentingAlert = isPresentingAlert
        self.searchText = searchText
        self.dataSource = dataSource
        self.cache = cache
        self.articles.formUnion(dataSource?.fetchArticles(for: request.searchIn) ?? [])
        if self.actualPage() == 1 { self.fetchArtcles() }
    }
    
    func sortBy(_ sort: String) {
        self.request.sortBy = sort
    }
    
    func setNextPageNeeds(article: Article) {
        if shouldGetNextPage(article: article) {
            self.getNextPage()
        }
    }
    
    private func getNextPage() {
        if let page = self.request.page,
           let pageNumber = Int(page) {
            self.request.page = String(pageNumber+1)
            self.fetchArtcles()
        }
    }
    
    private func sort(_ articles: any Sequence<Article>) -> [Article] {
        if request.sortBy == nil {
            return articles.sorted(by: {
                if let firstTitle = $0.title,
                   let secondTitle = $1.title {
                    return firstTitle > secondTitle
                }
                return false
            })
        }
        return []
    }
    
    private func shouldGetNextPage(article: Article) -> Bool {
        self.sortedArticles.last == article
    }
    
    @discardableResult
    private func actualPage() -> Int {
        guard let pageSize = request.pageSize,
              let size = Double(pageSize) else { return 1 }
        let page = Int((Double(self.articles.count+1)/size).rounded(.up))
        self.request.page = String(page)
        return Int(page)
    }
    
    func fetchArtcles() {
        networkManager.request(request,
                               using: .shared,
                               completion: { result in
            switch result {
            case .success(let response):
                // É DADO SORT SOMENTE NOS NOVOS ELEMENTOS DA PESQUISA! PARA NAO BAGUNCAR A PERCEPCAO DO USUARIO DO ANTEIROR E PROXIMOS, POREM A API JA DEVE FAZER O SORT AUTOMATICO , ENTÃO TEORICAMENTE ISSO NAO DEVE SER NECESSARIO
                let responseArticles = response.articles.map { $0.decode(searchTerm: self.request.searchIn) }
                self.articles.formUnion(responseArticles)
                self.saveArticles(self.articles)
            case .failure(let error):
                // Add LOGGER
                print(error.localizedDescription)
                self.isPresentingAlert = true
            }
        })
    }
    
}

extension ArticleListViewModel {
    func filterArticles(_ searchText: String,_ articles: [Article]) -> [Article] {
        let filteredKeys = articles.filter({
            guard let title: String = $0.title else { return false }
            return searchText.isEmpty ? true : title.localizedCaseInsensitiveContains(searchText)
        })
        return filteredKeys
    }
}

extension ArticleListViewModel {
    private func appendArticle(_ article: Article) {
            dataSource?.appendArticle(article)
        }

    private func removeArticle(_ article: Article) {
            dataSource?.removeArticle(article)
        }
    
    private func saveArticles(_ articles: Set<Article>) {
        dataSource?.saveArticles(articles: articles, for: request.searchIn)
        }
}
