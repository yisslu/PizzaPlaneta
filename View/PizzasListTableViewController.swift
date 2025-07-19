//
//  PizzasListTableViewController.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//

import UIKit

class PizzasListTableViewController: UITableViewController {
    let viewModel: PizzasListViewModel
    
    init(pizzasList: [PizzaModel.Pizza]){
        viewModel = PizzasListViewModel(pizzasList: pizzasList)
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "Pizzas"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
        
        viewModel.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.saveFavoritePizzasData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchNewPizzas()
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.numberOfRows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        
        var cellConfiguration = cell.defaultContentConfiguration()
        
        let pizza = viewModel.pizza(at: indexPath)
        
        let isFavorite = viewModel.isFavorite(pizza: pizza)
        
        var pizzaName: String
        
        if isFavorite {
            pizzaName = pizza.name + " ⭐️"
        } else {
            pizzaName = pizza.name
        }
        
        
        cellConfiguration.text = pizzaName

        cell.contentConfiguration = cellConfiguration
        
        return cell
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pizza = viewModel.pizza(at: indexPath)
        
        let isFavorite = viewModel.isFavorite(pizza: pizza)
        
        if isFavorite {
            let favoriteAction = UIContextualAction(style:.normal , title: "Add to favorites") { [weak self] _, _, completion in
            // tell view model to add  it favorites
            self?.viewModel.removePizzaOfFavorite(at: indexPath)
            
            completion(true)
        }
            favoriteAction.backgroundColor = .red
            favoriteAction.image = UIImage(systemName: "heart.slash")
            
            return UISwipeActionsConfiguration(actions: [favoriteAction])
        }else{
            let removeAction = UIContextualAction(style:.normal , title: "Add to favorites") { [weak self] _, _, completion in
                // tell view model to add  it favorites
                self?.viewModel.addPizzaToFavorite(at: indexPath)
                
                completion(true)
            }
            
            removeAction.backgroundColor = .red
            removeAction.image = UIImage(systemName: "heart")
            
            return UISwipeActionsConfiguration(actions: [removeAction])
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pizza = viewModel.pizza(at: indexPath)
        
        let pizzaDetailViewController = PizzaDetailViewController(pizza: pizza)
        
        navigationController?.pushViewController(pizzaDetailViewController, animated: true)
    }

}

extension PizzasListTableViewController: PizzasListViewModelDelegate {
    func shouldReloadTableData() {
        tableView.reloadData()
    }
}
