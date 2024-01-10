//
//  MockURLSession.swift
//  FetchMealsTests
//
//  Created by Tanuja Jasti on 1/8/24.
//

import Foundation
@testable import FetchMeals

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return MockURLSessionDataTask(completionHandler: completionHandler, data: data, response: response, error: error)
    }
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private let completionHandler: (Data?, URLResponse?, Error?) -> Void
    private let data: Data?
    private let response: URLResponse?
    private let error: Error?

    init(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void, data: Data?, response: URLResponse?, error: Error?) {
        self.completionHandler = completionHandler
        self.data = data
        self.response = response
        self.error = error
    }

    func resume() {
        completionHandler(data, response, error)
    }
}
