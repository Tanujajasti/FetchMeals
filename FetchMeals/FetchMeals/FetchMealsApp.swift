//
//  FetchMealsApp.swift
//  FetchMeals
//
//  Created by Tanuja Jasti on 1/5/24.
//

import SwiftUI

@main
struct FetchMealsApp: App {
    var body: some Scene {
        WindowGroup {
            MealsView()
                .environmentObject(MealsViewModel())
        }
    }
}

