//
//  FavoritePizzaViewModel.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 28/01/25.
//

import Foundation


class FavoritePizzaViewModel {
    
    private let favoritePizzasList = "favorite_pizza"
    private let favoritePizzeriasList = "favorite_pizzeria"
    private let pizzasListDataExtension = "json"
    
    private(set) var favoritePizzas: [PizzaModel.Pizza] = []
    private(set) var favoritePizzerias: [PizzaModel.Pizzeria] = []
    
    var numberOfSections: Int { 2 }
    var numberOfRowsForPizzas: Int { favoritePizzas.count }
    var numberOfRowsForPizzeria: Int { favoritePizzerias.count }
    var cellIdentifier = "FavoriteCells"
    
    init() {
        loadListsData()
    }
    
    func loadListsData() {
        let pizzaList: [PizzaModel.Pizza] = SaveDataModel.loadFavoriteData(from: favoritePizzasList, with: pizzasListDataExtension)
        
        let pizzeriaList: [PizzaModel.Pizzeria] = SaveDataModel.loadFavoriteData(from: favoritePizzeriasList, with: pizzasListDataExtension)
        
        favoritePizzas = pizzaList
        favoritePizzerias = pizzeriaList
    }
    
    func pizza(at position: IndexPath) -> PizzaModel.Pizza {
        return favoritePizzas[position.row]
    }
    
    func pizzeria(at position: IndexPath) -> PizzaModel.Pizzeria {
        favoritePizzerias[position.row]
    }
    
}
