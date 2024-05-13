//
//  ArticleListViewModelTests.swift
//  NewAppTests
//
//  Created by Gilberto Magno on 13/05/24.
//

import Foundation

import XCTest
@testable import NewApp


final class ArticleListViewModelTests: XCTestCase {
    var sut: ArticleListViewModelProtocol!
    
    override func setUp() {
        sut = ArticleListViewModel(articles: [.init(author: "Mocked Author",
                                                    title: "Mocked Title", searchTerm: "Mock"),
                                              .init(author: "Mocked Author2",
                                                    title: "Mocked Title2", searchTerm: "Mock"),
                                              .init(author: "Mocked Author3",
                                                    title: "Mocked Title3", searchTerm: "Mock"),
                                              .init(author: "Mocked Author4",
                                                    title: "Mocked Title4", searchTerm: "Mock"),
                                              .init(author: "Mocked Author5",
                                                    title: "Mocked Title5", searchTerm: "Mock"),
                                              .init(author: "Mocked Author6",
                                                    title: "Mocked Title6", searchTerm: "Mock"),
                                              .init(author: "Mocked Author7",
                                                    title: "Mocked Title7", searchTerm: "Mock"),
                                              .init(author: "Mocked Author8",
                                                    title: "Mocked Title8", searchTerm: "Mock"),
                                              .init(author: "Mocked Author9",
                                                    title: "Mocked Title9", searchTerm: "Mock"),
                                              .init(author: "Mocked Author10",
                                                    title: "Mocked Title10", searchTerm: "Mock"),],
                                   request: .init(searchIn: "Metroidvania"),
                                   dataSource: nil, cache: nil)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_setNextPageNeeds_whenNotNeeds() {
        let articles = self.sut.filteredArticles
        sut.setNextPageNeeds(article: .init(author: "Mocked Author",
                                            title: "Mocked Title", searchTerm: "Mock"))
        let resultArticles = self.sut.filteredArticles
        XCTAssertEqual(articles, resultArticles)
    }
    
    func test_setNextPageNeeds_whenNeeds_For2Seconds() {
        let expectation = XCTestExpectation(description: "The call values return takes some time.")
        let articles = self.sut.filteredArticles
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.sut.setNextPageNeeds(article: .init(author: "Mocked Author10",
                                                     title: "Mocked Title10",
                                                     searchTerm: "Mock"))
            let resultArticles = self.sut.filteredArticles
            XCTAssertNotEqual(articles, resultArticles)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
