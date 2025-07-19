//
//  NavigationTabViewController.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//

import UIKit

class NavigationTabViewController: UITabBarController {
    
    private let pizzasListDataName = "pizza-info"
    private let pizzasListDataExtension = "json"
    private let dataModel: PizzaModel
    
    init(){
        dataModel = SaveDataModel.fetchInfoPizzas(from: pizzasListDataName, with: pizzasListDataExtension)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewControllers()
    }
    

    private func setupViewControllers () {
        let pizzasListViewController = PizzasListTableViewController(pizzasList: dataModel.pizzasList)
        pizzasListViewController.tabBarItem.image = UIImage(systemName: "fork.knife.circle")
        pizzasListViewController.tabBarItem.selectedImage = UIImage(systemName: "fork.knife.circle.fill")
        pizzasListViewController.tabBarItem.title = "Pizzas"
        
        let pizzasListNavigationController = UINavigationController(rootViewController: pizzasListViewController)
        
        let pizzeriaListViewController = PizzeriaListTableViewController(pizzeriaList: dataModel.pizzeriasList)
        pizzeriaListViewController.tabBarItem.image = UIImage(systemName: "storefront")
        pizzeriaListViewController.tabBarItem.selectedImage = UIImage(systemName: "storefront.fill")
        pizzeriaListViewController.tabBarItem.title = "Pizzeria"
        
        let pizzeriaLisNavigationController = UINavigationController(rootViewController: pizzeriaListViewController)
        
        let favoritePizzaListViewController = FavoritePizzaTableViewController(style: .insetGrouped)
        favoritePizzaListViewController.tabBarItem.image = UIImage(systemName: "heart")
        favoritePizzaListViewController.tabBarItem.selectedImage = UIImage(systemName: "heart.fill")
        favoritePizzaListViewController.tabBarItem.title = "Favorites"
        
        let favoritePizzaListNavigationController = UINavigationController(rootViewController: favoritePizzaListViewController)
        
        let ingredientsListViewController = PickIngredientsTableViewController(ingredients: dataModel.ingredientsList)
        ingredientsListViewController.tabBarItem.image = UIImage(systemName: "checklist.unchecked")
        ingredientsListViewController.tabBarItem.selectedImage = UIImage(systemName: "checklist.checked")
        ingredientsListViewController.tabBarItem.title = "Ingredients"
        
        let pickIngredientsNavigationController = UINavigationController(rootViewController: ingredientsListViewController)
        
        
        viewControllers = [pizzasListNavigationController, pizzeriaLisNavigationController, favoritePizzaListNavigationController,pickIngredientsNavigationController]
        
    }

}
