//
//  Pizza.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//


struct PizzaModel: Codable {
    
    
    struct Pizza: Codable {
        let name: String
        let ingredients: [String]
        
        private enum CodingKeys: String, CodingKey {
            case name, ingredients
        }
    }
    
    struct Pizzeria: Codable {
        let pizzeriaName: String
        
        let pizzeriaAddress: String
        
        let currentLocation: Location?
        
        private enum CodingKeys: String, CodingKey {
            case pizzeriaName = "name"
            case pizzeriaAddress = "address"
            case currentLocation = "coordinates"
        }
    }
    
    struct Location: Codable {
        let latitude: Double
        let longitude: Double
    }
    
    var pizzasList: [Pizza]
    let pizzeriasList: [Pizzeria]
    let ingredientsList: [String]
    
    private enum CodingKeys: String, CodingKey {
        case pizzasList = "pizzas"
        case pizzeriasList = "pizzerias"
        case ingredientsList = "ingredients"
    }
    
}

extension PizzaModel.Pizza:Equatable, Hashable{
    static func == (lhs: PizzaModel.Pizza, rhs: PizzaModel.Pizza) -> Bool {
        lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

extension PizzaModel.Pizzeria:Equatable, Hashable{
    static func == (lhs: PizzaModel.Pizzeria, rhs: PizzaModel.Pizzeria) -> Bool {
        lhs.pizzeriaName == rhs.pizzeriaName
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(pizzeriaName)
    }
}
