//
//  NewAppApp.swift
//  NewApp
//
//  Created by Gilberto Magno on 11/05/24.
//

import SwiftUI
import SwiftData

@main
struct NewAppApp: App {
    
    var termManager: TermManager = .init()

    var body: some Scene {
        WindowGroup {
            TermsArticleView(viewModel: .init(terms: termManager.getTerms()))
        }
    }
}
