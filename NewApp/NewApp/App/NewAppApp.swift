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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Article.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            
                TermsArticleView(viewModel: .init(boxes: [
                    (Everything.Request(searchIn: "Teste",
                                        pageSize: "10", page: "1"),.aquamarine),
                    (Everything.Request(searchIn: "MetroidVania",
                                        pageSize: "10", page: "1"),.mauve),
                    (Everything.Request(searchIn: "Fallout",
                                        pageSize: "10", page: "1"),.lavender),
                    (Everything.Request(searchIn: "Isotopos",
                                        pageSize: "10", page: "1"),.aquamarine),
                    (Everything.Request(searchIn: "Fome",
                                        pageSize: "10", page: "1"),.aquamarine),
                    (Everything.Request(searchIn: "Hunger",
                                        pageSize: "10", page: "1"),.lavender),
                    (Everything.Request(searchIn: "Games",
                                        pageSize: "10", page: "1"),.lavender),
                ]))
            
        }
        .modelContainer(sharedModelContainer)
    }
}
