//
//  Untitled.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//

import Foundation
import UIKit

protocol PizzasListViewModelDelegate {
    func shouldReloadTableData()
}

class PizzasListViewModel {
    
    private let favoritePizzasList = "favorite_pizza"
    private let pizzasListDataExtension = "json"
    
    private(set) var pizzasList: [PizzaModel.Pizza] = []
    
    var favoritePizza: Set<PizzaModel.Pizza> = []
    
    var numberOfSections: Int { 1 }
    var numberOfRows: Int { pizzasList.count }
    var cellIdentifier = "PizzaCell"
    
    var delegate: PizzasListViewModelDelegate?
    
    init(pizzasList: [PizzaModel.Pizza]){
        self.pizzasList = pizzasList
        let pizzaList: [PizzaModel.Pizza] = SaveDataModel.loadFavoriteData(from: favoritePizzasList, with: pizzasListDataExtension)
        favoritePizza = Set(pizzaList)
        
        NotificationCenter.default.addObserver(self, selector: #selector(saveFavoritePizzasData), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    
    func isFavorite(pizza: PizzaModel.Pizza) -> Bool {
        favoritePizza.contains(pizza)
    }
    
    func pizza(at position: IndexPath) -> PizzaModel.Pizza {
        pizzasList[position.row]
    }
    
    func addPizzaToFavorite(at indexPath: IndexPath){
        let pizza = pizza(at: indexPath)
        favoritePizza.insert(pizza)
        delegate?.shouldReloadTableData()
    }
    
    func removePizzaOfFavorite(at indexPath: IndexPath){
        let pizza = pizza(at: indexPath)
        favoritePizza.remove(pizza)
        delegate?.shouldReloadTableData()
    }
    
    @objc
    func saveFavoritePizzasData() {
        SaveDataModel.saveFavoritePizzas(favoritePizza, in: favoritePizzasList, with: pizzasListDataExtension)
    }
    
    func fetchNewPizzas() {
        var pizzaModel = SaveDataModel.fetchInfoPizzas(from: "pizza-info", with: "json")
        let newPizzas: [PizzaModel.Pizza] = SaveDataModel.loadFavoriteData(from: "new_pizzas", with: "json")
        pizzaModel.pizzasList = newPizzas + pizzaModel.pizzasList
        pizzasList = pizzaModel.pizzasList
        delegate?.shouldReloadTableData()
    }
}
