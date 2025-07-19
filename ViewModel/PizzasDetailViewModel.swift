//
//  PizzasDetailViewModel.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//
import Foundation

class PizzasDetailViewModel {
    private let pizza: PizzaModel.Pizza
    
    
    init(pizza: PizzaModel.Pizza) {
        self.pizza = pizza
    }
    
    var cellIdentifier: String { "ingredientCell" }
    var numberOfSection: Int {1}
    var numberOfRows: Int { pizza.ingredients.count }
    var name: String { pizza.name }
    
    func ingredients(at position: IndexPath) -> String{
        pizza.ingredients[position.row]
    }
}
