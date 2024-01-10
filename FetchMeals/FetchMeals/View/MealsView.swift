//
//  MealsView.swift
//  FetchMeals
//
//  Created by Tanuja Jasti on 1/5/24.
//

import SwiftUI

struct MealsView: View {
    @EnvironmentObject var viewModel: MealsViewModel

    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: RecipeView(mealID: meal.idMeal)) {
                    Text(meal.strMeal)
                }
            }
            .listStyle(SidebarListStyle())
            .navigationBarTitle("Desserts")
        }
        .onAppear {
            viewModel.fetchMeals()
        }
    }
}

