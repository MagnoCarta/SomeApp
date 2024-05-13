//
//  TermsArticleRouter.swift
//  NewApp
//
//  Created by Gilberto Magno on 12/05/24.
//

import SwiftUI

@Observable
class NARouter {
    var path: NavigationPath = .init()
    
    private init() {}
    
    func pushToTerm(_ term: Everything.Request) {
        self.path.append(term)
    }
    
    func pushToArticle(_ article: Article) {
        self.path.append(article)
    }
    
    static let shared: NARouter = .init()
    
}
