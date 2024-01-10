//
//  RecipeViewModel.swift
//  FetchMeals
//
//  Created by Tanuja Jasti on 1/7/24.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipe: Recipe?
    private var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchRecipe(for mealID: String) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            return
        }

        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    self?.recipe = nil
                }
                return
            }
            
            do {
                let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.recipe = recipeResponse.meals.first
                }
            } catch {
                DispatchQueue.main.async {
                    self?.recipe = nil
                }
            }
        }
        
        task.resume()
    }
}

struct RecipeResponse: Codable {
    var meals: [Recipe]
}
