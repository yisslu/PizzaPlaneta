//
//  SaveDataModel.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 27/01/25.
//

import Foundation


struct SaveDataModel {
    
    static func saveFavoritePizzas<T>(_ list: Set<T>,in fileName: String, with fileExtension: String) where T: Encodable {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        else {
            assertionFailure("Couldn't find documents directory")
            return
        }
        
        let filename = "\(fileName).\(fileExtension)"
        
        let fileURL = documentsDirectory.appending(component: filename)
        
        let favoritePizza = Array(list)
        
        do{
            let favoritePizzaData = try JSONEncoder().encode(favoritePizza)
            
            let jsonFavoritePizza = String(data: favoritePizzaData, encoding: .utf8)
            try jsonFavoritePizza?.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            assertionFailure("Cannot enconde favorite pizzas: \(error.localizedDescription)")
        }
    }
    
    static func fetchInfoPizzas(from fileName: String, with fileExtension: String) -> PizzaModel{
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension), let pizzaListData = try? Data(contentsOf: fileURL), let pizzasList = try? JSONDecoder().decode(PizzaModel.self, from: pizzaListData) else { assertionFailure("Cannot find \(fileName).\(fileExtension)")
            return PizzaModel(pizzasList: [], pizzeriasList: [], ingredientsList: [])}
        return pizzasList
    }
    
    static func loadFavoriteData<T>(from fileName: String, with fileExtension:String) -> [T] where T: Codable{
        guard let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return []
        }
        
        let favoriteDataURL = documentsURL.appending(component: "\(fileName).\(fileExtension)")
        
        do {
            let favoriteData = try Data(contentsOf:  favoriteDataURL)
            let favoriteList = try JSONDecoder().decode([T].self, from: favoriteData)
            return favoriteList
        } catch {
//            assertionFailure("Cannot load favorite file")
            return []
        }
    }
}
