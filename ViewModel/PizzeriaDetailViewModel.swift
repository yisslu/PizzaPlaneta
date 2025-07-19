//
//  PizzeriaDetailViewModel.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//

import Foundation


class PizzeriaDetailViewModel {
    
    private var pizzeria: PizzaModel.Pizzeria
    
    init(pizzeria: PizzaModel.Pizzeria){
        self.pizzeria = pizzeria
    }
    
    var pizzeriaName: String { pizzeria.pizzeriaName }
    
    var currentLocation: String { pizzeria.pizzeriaAddress }
    
    var coordinates: PizzaModel.Location? { pizzeria.currentLocation }
    
}
