//
//  MealsViewModel.swift
//  FetchMeals
//
//  Created by Tanuja Jasti on 1/5/24.
//

import Foundation

class MealsViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    private var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchMeals() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    self?.meals = []
                }
                return
            }
            
            do {
                let mealsResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.meals = mealsResponse.meals.filter { !$0.strMeal.isEmpty }
                }
            } catch {
                DispatchQueue.main.async {
                    self?.meals = []
                }
            }
        }
        
        task.resume()
    }
}

struct MealsResponse: Codable {
    var meals: [Meal]
}
