//
//  PizzeriaListTableViewController.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//

import UIKit

class PizzeriaListTableViewController: UITableViewController {
    let viewModel: PizzeriaListViewModel
    
    
    init(pizzeriaList: [PizzaModel.Pizzeria]){
        viewModel = PizzeriaListViewModel(pizzeriaList: pizzeriaList)
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.title = "Pizzerias"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
        
        viewModel.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.callSaveFavoritePizzasFunction()
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
        
        let pizzeria = viewModel.pizzeria(at: indexPath)
        
        let isFavorite = viewModel.isFavorite(pizzeria: pizzeria)
        
        var pizzeriaName: String
        
        if isFavorite {
            pizzeriaName = pizzeria.pizzeriaName + " ⭐️"
        } else {
            pizzeriaName = pizzeria.pizzeriaName
        }
        
        
        cellConfiguration.text = pizzeriaName

        cell.contentConfiguration = cellConfiguration
        
        return cell
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let pizzeria = viewModel.pizzeria(at: indexPath)
        
        let isFavorite = viewModel.isFavorite(pizzeria: pizzeria)
        
        if isFavorite {
            let favoriteAction = UIContextualAction(style:.normal , title: "Add to favorites") { [weak self] _, _, completion in
            // tell view model to add  it favorites
            self?.viewModel.removePizzeriaOfFavorite(at: indexPath)
            
            completion(true)
        }
            favoriteAction.backgroundColor = .red
            favoriteAction.image = UIImage(systemName: "heart.slash")
            
            return UISwipeActionsConfiguration(actions: [favoriteAction])
        }else{
            let removeAction = UIContextualAction(style:.normal , title: "Add to favorites") { [weak self] _, _, completion in
                // tell view model to add  it favorites
                self?.viewModel.addPizzeriaToFavorite(at: indexPath)
                
                completion(true)
            }
            
            removeAction.backgroundColor = .red
            removeAction.image = UIImage(systemName: "heart")
            
            return UISwipeActionsConfiguration(actions: [removeAction])
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pizzeria = viewModel.pizzeria(at: indexPath)
        
        let pizzeriaDetailViewController = PizzeriaDetailViewController(pizzeria: pizzeria)
        
        navigationController?.pushViewController(pizzeriaDetailViewController, animated: true)
    }

}

extension PizzeriaListTableViewController: PizzeriaLisViewModelDelegate {
    func shouldReloadTableData() {
        tableView.reloadData()
    }
}
