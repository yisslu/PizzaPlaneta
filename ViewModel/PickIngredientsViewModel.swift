//
//  PickIngredientsViewModel.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 31/01/25.
//

import Foundation


class PickIngredientsViewModel {
    
    var ingredients: [String] = []
    
    let cellIdentifier: String = "ingredientCell"
    var numberOfSections: Int { 1 }
    var numberOfRowsInSections: Int { ingredients.count }
    var newIngredientsList: Set<String> = []
    var newPizzaName: String?
    var newPizzasList: [PizzaModel.Pizza] = []
    
    init(ingredients: [String]) {
        self.ingredients = ingredients
    }
    
    func ingredient(at indexPath: IndexPath) -> String{
        ingredients[indexPath.row]
    }
    
    func isSelected(this ingredient: String) -> Bool {
        newIngredientsList.contains(ingredient)
    }
    
    func addToListOfIngredients(at indexPath: IndexPath) {
        let ingredient = ingredient(at: indexPath)
        newIngredientsList.insert(ingredient)
    }
    
    func removeToListOfIngredients(at indexPath: IndexPath) {
        let ingredient = ingredient(at: indexPath)
        newIngredientsList.remove(ingredient)
    }
    
    func numberOfIngredients() -> Int {
        newIngredientsList.count
    }
    
    func saveNewPizza() {
        
        let newPizza = PizzaModel.Pizza(name: newPizzaName ?? "New", ingredients: Array(newIngredientsList))
        newPizzasList.append(newPizza)
        SaveDataModel.saveFavoritePizzas(Set(newPizzasList), in: "new_pizzas", with: "json")
    }
    
    func deleteSelections() {
        newIngredientsList.removeAll()
    }
}
