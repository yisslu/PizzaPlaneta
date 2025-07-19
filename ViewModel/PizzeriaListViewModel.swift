//
//  PizzeriaListViewModel.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//

import Foundation
import UIKit

protocol PizzeriaLisViewModelDelegate {
    func shouldReloadTableData()
}

class PizzeriaListViewModel {
    private let favoriteListPizzas = "favorite_pizzeria"
    private let pizzasListDataExtension = "json"
    
    private(set) var pizzeriaList: [PizzaModel.Pizzeria] = []
    
    var favoritePizzeria: Set<PizzaModel.Pizzeria> = []
    
    var numberOfSections: Int { 1 }
    var numberOfRows: Int { pizzeriaList.count }
    var cellIdentifier = "PizzaCell"
    
    var delegate: PizzeriaLisViewModelDelegate?
    
    init(pizzeriaList: [PizzaModel.Pizzeria]){
        self.pizzeriaList = pizzeriaList
        
        let pizzeriaList: [PizzaModel.Pizzeria] = SaveDataModel.loadFavoriteData(from: favoriteListPizzas, with: pizzasListDataExtension)
        favoritePizzeria = Set(pizzeriaList)
        
        NotificationCenter.default.addObserver(self, selector: #selector(callSaveFavoritePizzasFunction), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    func isFavorite(pizzeria: PizzaModel.Pizzeria) -> Bool {
        favoritePizzeria.contains(pizzeria)
    }
    
    func pizzeria(at position: IndexPath) -> PizzaModel.Pizzeria {
        pizzeriaList[position.row]
    }
    
    func addPizzeriaToFavorite(at indexPath: IndexPath){
        let pizzeria = pizzeria(at: indexPath)
        favoritePizzeria.insert(pizzeria)
        delegate?.shouldReloadTableData()
    }
    
    func removePizzeriaOfFavorite(at indexPath: IndexPath){
        let pizzeria = pizzeria(at: indexPath)
        favoritePizzeria.remove(pizzeria)
        delegate?.shouldReloadTableData()
    }
    
    @objc
    func callSaveFavoritePizzasFunction(){
        SaveDataModel.saveFavoritePizzas(favoritePizzeria, in: favoriteListPizzas, with: pizzasListDataExtension)
    }
}

