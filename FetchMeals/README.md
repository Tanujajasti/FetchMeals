# FetchMeals

A basic native iOS app that allows users to browse through a list of meals and displays detailed recipe of the meal when clicked 


###
- App was build on Xcode(Version 15.x.x)
- Swift
- SwiftUI
- MVVM Architecture


## Current Features
- App is built to be compatible with both iPhone and iPad
- Supports Light/Dark mode
- Supports Portrait/Landscape
- Includes tests


## Project Breakdown
FetchMealsApp.swift - Entry point for the application.
URLSessionProtocol.swift - Defines protocols related to network requests.

MealsView.swift - Defines the view for displaying the list of meals.
RecipeView.swift - This view is responsible for displaying the details of a selected meal.

MealsViewModel.swift - View model that handles the logic for fetching meal data from the API.
RecipeViewModel.swift - Similar to MealsViewModel, but focused on individual recipes.

MealsModel.swift - Defines the data model for a meal.
RecipeModel.swift - Defines the data model for a recipe i.e. Meal details.

MockURLSession.swift - A mock version of URLSession used for testing.
MealsViewModelTests.swift - Unit tests for MealsViewModel. 
RecipeViewModelTests.swift - Unit tests for RecipeViewModel. 
MealsIntegrationTests.swift - Tests that focus on the integration of different components in the meals feature. 


## Usage
### IPhone
- When you launch the app, a list of Dessert names are displayed in a list.
- Tap on the Dessert you find interesting
- You will now be displayed a beautiful image of the dessert, ingredients with measure and detailed instruction on how to make it.
### IPad
- Tap on the list icon on the top-left corner
- You will see a list of dessert names
- Tap on the Dessert you find interesting
- You will now be displayed a beautiful image of the dessert, ingredients with measure and detailed instruction on how to make it.
- Unlike Iphone, you dont have to exit the current recipe page to view the list again. Just click on the same list icon and you can see the list.


## Further Improvements
- We can include local data storage(like User Defaults, Core Data...)
- User experience enhancements like Custom views, Animations and Transiions
- A more structured and informative error handling approach where we log or propagate the error to the caller
- Feature additions like search functionality where users can search for a particular Meal, Like functionality where they can Like or mark a recipe as favourite, Review functionality where users can try out the recipe and tell us how it turned out and if they liked it.





