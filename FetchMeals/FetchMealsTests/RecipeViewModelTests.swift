//
//  RecipeViewModelTests.swift
//  FetchMealsTests
//
//  Created by Tanuja Jasti on 1/8/24.
//

import XCTest
@testable import FetchMeals

class RecipeViewModelTests: XCTestCase {
    var viewModel: RecipeViewModel!
    var mockSession: MockURLSession!

    override func setUp() {
        super.setUp()
        let mockData = mockRecipeData()
        let mockResponse = HTTPURLResponse(url: URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=53049")!,
                                           statusCode: 200, httpVersion: nil, headerFields: nil)
        let mockError: Error? = nil
        mockSession = MockURLSession(data: mockData, response: mockResponse, error: mockError)
        viewModel = RecipeViewModel(session: mockSession)
    }

    func testFetchRecipeSuccess() {
        mockSession.data = mockRecipeData()
        mockSession.response = HTTPURLResponse(url: URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=53049")!,
                                               statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession.error = nil

        let expectation = self.expectation(description: "FetchRecipeSuccess")

        viewModel.fetchRecipe(for: "53049")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.recipe, "Recipe should not be nil")
            XCTAssertEqual(self.viewModel.recipe?.idMeal, "53049", "Recipe ID should match the mock data")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }


    func testFetchRecipeFailure() {
        let nilData: Data? = nil
        let nilResponse: URLResponse? = nil
        let error: Error? = MockError.testError

        mockSession = MockURLSession(data: nilData, response: nilResponse, error: error)
        viewModel = RecipeViewModel(session: mockSession)

        viewModel.fetchRecipe(for: "InvalidID")

        let expectation = self.expectation(description: "FetchRecipeFailure")

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNil(self.viewModel.recipe, "Recipe should be nil on fetch failure")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2.0, handler: nil)
    }

    private func mockRecipeData() -> Data {
        let jsonString = """
        {
            "meals": [
                {
                    "idMeal": "53049",
                    "strMeal": "Apam balik",
                    "strInstructions": "Some instructions",
                    "strMealThumb": "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg",
                    "strIngredient1": "Ingredient1",
                    "strIngredient2": "Ingredient2",
                    "strMeasure1": "Measure1",
                    "strMeasure2": "Measure2"

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
