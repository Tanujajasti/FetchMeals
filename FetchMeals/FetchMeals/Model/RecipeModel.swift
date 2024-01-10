//
//  RecipeModel.swift
//  FetchMeals
//
//  Created by Tanuja Jasti on 1/7/24.
//

import Foundation

struct Recipe: Codable {
    var idMeal: String
    var strMeal: String
    var strInstructions: String
    var strMealThumb: String
    var ingredients: [String] = []
    var measures: [String] = []

    enum CodingKeys: String, CodingKey {
        case idMeal, strMeal, strInstructions, strMealThumb
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10, strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10, strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)

        // Decoding ingredients and measures
        for index in 1...20 {
            let ingredientKey = CodingKeys(rawValue: "strIngredient\(index)")
            let measureKey = CodingKeys(rawValue: "strMeasure\(index)")

            if let ingredientKey = ingredientKey, let ingredient = try container.decodeIfPresent(String.self, forKey: ingredientKey), !ingredient.trimmingCharacters(in: .whitespaces).isEmpty {
                ingredients.append(ingredient)
            }

            if let measureKey = measureKey, let measure = try container.decodeIfPresent(String.self, forKey: measureKey), !measure.trimmingCharacters(in: .whitespaces).isEmpty {
                measures.append(measure)
            }
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(idMeal, forKey: .idMeal)
        try container.encode(strMeal, forKey: .strMeal)
        try container.encode(strInstructions, forKey: .strInstructions)
        try container.encode(strMealThumb, forKey: .strMealThumb)

        // Encoding ingredients and measures
        for index in 1...20 {
            let ingredientKey = CodingKeys(rawValue: "strIngredient\(index)")
            let measureKey = CodingKeys(rawValue: "strMeasure\(index)")

            if let ingredientKey = ingredientKey, index <= ingredients.count {
                try container.encode(ingredients[index - 1], forKey: ingredientKey)
            }

            if let measureKey = measureKey, index <= measures.count {
                try container.encode(measures[index - 1], forKey: measureKey)
            }
        }
    }
}

