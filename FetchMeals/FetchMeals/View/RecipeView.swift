//
//  RecipeView.swift
//  FetchMeals
//
//  Created by Tanuja Jasti on 1/5/24.
//
//

import SwiftUI

struct RecipeView: View {
    @StateObject private var viewModel = RecipeViewModel()
    var mealID: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let recipe = viewModel.recipe {
                    Text(recipe.strMeal)
                        .font(.title)

                    AsyncImage(url: URL(string: recipe.strMealThumb)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }

                    Text("Ingredients:")
                        .font(.headline)
                        .padding(.top, 8)

                    ForEach(Array(zip(recipe.ingredients, recipe.measures)), id: \.0) { ingredient, measure in
                        Text("- \(ingredient): \(measure)")
                    }

                    Text("Instructions:")
                        .font(.headline)
                        .padding(.top, 8)

                    Text(recipe.strInstructions)
                        .padding(.top, 4)
                        .multilineTextAlignment(.leading)
                }
            }
            .padding()
            .navigationBarTitle("Recipe", displayMode: .inline)
        }
        .onAppear {
            viewModel.fetchRecipe(for: mealID)
        }
    }
}
