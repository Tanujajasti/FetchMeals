//
//  MealsIntegrationTests.swift
//  FetchMealsTests
//
//  Created by Tanuja Jasti on 1/9/24.
//

import XCTest
@testable import FetchMeals

class MealsIntegrationTests: XCTestCase {
    var viewModel: MealsViewModel!
    var mockSession: MockURLSession!

    override func setUp() {
        super.setUp()

        let mockData = """
        {
            "meals": [
                {
                    "idMeal": "52977",
                    "strMeal": "Apple Frangipan Tart",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/wxywrq1468235067.jpg"
                },
                {
                    "idMeal": "52768",
                    "strMeal": "Tarte Tatin",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/ryspuw1511786688.jpg"
                }
            ]
        }
        """.data(using: .utf8)!
        let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!
        let mockResponse = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!

        mockSession = MockURLSession(data: mockData, response: mockResponse, error: nil)
        viewModel = MealsViewModel(session: mockSession)
    }

    func testFetchAndDisplayMeals() {
        let expectation = XCTestExpectation(description: "Fetch meals")

        viewModel.fetchMeals()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)

        let expectedCount = 2
        XCTAssertEqual(viewModel.meals.count, expectedCount)
    }

    
    override func tearDown() {
        viewModel = nil
        mockSession = nil
        super.tearDown()
    }
}
