//
//  FavoritePizzaTableViewController.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//

import UIKit

class FavoritePizzaTableViewController: UITableViewController {

    private let viewModel = FavoritePizzaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Favorites"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.loadListsData()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 && viewModel.numberOfRowsForPizzas > 0{
            return "Pizzas"
        } else if section == 1 && viewModel.numberOfRowsForPizzeria > 0{
            return "Pizzerias"
        }
        return nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            viewModel.numberOfRowsForPizzas
        } else {
            viewModel.numberOfRowsForPizzeria
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        
        var cellConfiguration = cell.defaultContentConfiguration()
        
        if indexPath.section == 0 {
            let pizza = viewModel.pizza(at: indexPath)
            cellConfiguration.text = pizza.name
        } else {
            let pizzeria = viewModel.pizzeria(at: indexPath)
            cellConfiguration.text = pizzeria.pizzeriaName
        }
        
        cell.contentConfiguration = cellConfiguration
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let pizza = viewModel.pizza(at: indexPath)
            
            let pizzaDetailViewController = PizzaDetailViewController(pizza: pizza)
            
            navigationController?.pushViewController(pizzaDetailViewController, animated: true)
        } else {
            let pizzeria = viewModel.pizzeria(at: indexPath)
            
            let pizzeriaDetailViewController = PizzeriaDetailViewController(pizzeria: pizzeria)
            
            navigationController?.pushViewController(pizzeriaDetailViewController, animated: true)
        }
        
    }
}
