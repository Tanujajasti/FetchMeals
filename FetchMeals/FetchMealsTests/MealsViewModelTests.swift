//
//  MealsViewModelTests.swift
//  FetchMealsTests
//
//  Created by Tanuja Jasti on 1/8/24.
//

import XCTest
@testable import FetchMeals

class MealsViewModelTests: XCTestCase {
    var viewModel: MealsViewModel!
    var mockSession: MockURLSession!

    override func setUp() {
        super.setUp()
        let mockData = mockMealsData()
        let mockResponse = HTTPURLResponse(url: URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!,
                                           statusCode: 200, httpVersion: nil, headerFields: nil)
        let mockError: Error? = nil
        mockSession = MockURLSession(data: mockData, response: mockResponse, error: mockError)
        viewModel = MealsViewModel(session: mockSession)
    }

    func testFetchMealsSuccess() {
        mockSession.data = mockMealsData()
        mockSession.response = HTTPURLResponse(url: URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert")!,
                                               statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession.error = nil

        let expectation = self.expectation(description: "FetchMealsSuccess")

        viewModel.fetchMeals()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.meals.count, 3)
            XCTAssertEqual(self.viewModel.meals[0].idMeal, "52977")
            XCTAssertEqual(self.viewModel.meals[0].strMeal, "Apple Frangipan Tart")
            XCTAssertEqual(self.viewModel.meals[1].idMeal, "52768")
            XCTAssertEqual(self.viewModel.meals[1].strMeal, "Tarte Tatin")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
    func testFetchMealsFailure() {
            let nilData: Data? = nil
            let nilResponse: URLResponse? = nil
            let error: Error? = MockError.testError

            mockSession = MockURLSession(data: nilData, response: nilResponse, error: error)
            viewModel = MealsViewModel(session: mockSession)
            viewModel.meals = []

            let expectation = self.expectation(description: "FetchMealsFailure")

            viewModel.fetchMeals()

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                XCTAssertTrue(self.viewModel.meals.isEmpty, "Meals list should be empty on fetch failure")
                expectation.fulfill()
            }

            waitForExpectations(timeout: 2.0, handler: nil)
        }

    private func mockMealsData() -> Data {
        let jsonString = """
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
                },
                {
                    "idMeal": "53049",
                    "strMeal": "Apam balik",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"
                }
            ]
        }
        """
        return Data(jsonString.utf8)
    }

    override func tearDown() {
        viewModel = nil
        mockSession = nil
        super.tearDown()
    }
    
    enum MockError: Error {
            case testError
        }
}
