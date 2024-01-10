//
//  MealsModel.swift
//  FetchMeals
//
//  Created by Tanuja Jasti on 1/5/24.
//

import Foundation

struct Meal: Identifiable, Codable {
    var id: String {
        idMeal
    }
    
    var idMeal: String
    var strMeal: String
    var strMealThumb: String
}

