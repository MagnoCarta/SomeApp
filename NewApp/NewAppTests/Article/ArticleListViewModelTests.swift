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
                                                    title: "Mocked Title"),
                                              .init(author: "Mocked Author2",
                                                    title: "Mocked Title2"),
                                              .init(author: "Mocked Author3",
                                                    title: "Mocked Title3"),
                                              .init(author: "Mocked Author4",
                                                    title: "Mocked Title4"),
                                              .init(author: "Mocked Author5",
                                                    title: "Mocked Title5"),
                                              .init(author: "Mocked Author6",
                                                    title: "Mocked Title6"),
                                              .init(author: "Mocked Author7",
                                                    title: "Mocked Title7"),
                                              .init(author: "Mocked Author8",
                                                    title: "Mocked Title8"),
                                              .init(author: "Mocked Author9",
                                                    title: "Mocked Title9"),
                                              .init(author: "Mocked Author10",
                                                    title: "Mocked Title10"),],
                                   request: .init(searchIn: "Metroidvania"),
                                   dataSource: nil, cache: nil)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_setNextPageNeeds_whenNotNeeds() {
        let articles = self.sut.filteredArticles
        sut.setNextPageNeeds(article: .init(author: "Mocked Author",
                                            title: "Mocked Title"))
        let resultArticles = self.sut.filteredArticles
        XCTAssertEqual(articles, resultArticles)
    }
    
    func test_setNextPageNeeds_whenNeeds_For2Seconds() {
        let expectation = XCTestExpectation(description: "The call values return takes some time.")
        let articles = self.sut.filteredArticles
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.sut.setNextPageNeeds(article: .init(author: "Mocked Author10",
                                                title: "Mocked Title10"))
            let resultArticles = self.sut.filteredArticles
            XCTAssertNotEqual(articles, resultArticles)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
