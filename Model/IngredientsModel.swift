//
//  IngredientsModel.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//

import Foundation


struct IngredientsModel: Codable {
    let ingredients: [String]
    
    private enum CodingKeys: String, CodingKey {
        case ingredients
    }
}
