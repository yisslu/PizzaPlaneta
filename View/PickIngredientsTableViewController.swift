//
//  PickIngredientsTableViewController.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 31/01/25.
//

import UIKit

class PickIngredientsTableViewController: UITableViewController {

    private var viewModel: PickIngredientsViewModel
    
    private lazy var buttonAlert: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAlert))
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
        createNewPizzaButton()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Pick ingredients"
    }
    
    init(ingredients: [String]){
        viewModel = PickIngredientsViewModel(ingredients: ingredients)
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createNewPizzaButton() {
        if viewModel.numberOfIngredients() > 0 {
            buttonAlert.isEnabled = true
        } else {
            buttonAlert.isEnabled = false
        }
        navigationItem.setRightBarButton(buttonAlert, animated: true)
    }
    
    @objc
    private func showAlert(){
        let ac = UIAlertController(title: "Create new pizza", message: "Please, enter a name of a Pizza", preferredStyle: .alert)
            ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .cancel) { [unowned ac] _ in
                let answer = ac.textFields![0]
                
            if answer.text == "" {
                print("not name")
            } else {
                self.viewModel.newPizzaName = answer.text
                self.viewModel.saveNewPizza()
                self.viewModel.deleteSelections()
                self.tableView.reloadData()
                self.buttonAlert.isEnabled = false
            }
            }

            ac.addAction(submitAction)

            present(ac, animated: true)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return viewModel.numberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.numberOfRowsInSections
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        let ingredient = viewModel.ingredient(at: indexPath)
        
        var cellConfiguration = cell.defaultContentConfiguration()
        
        cellConfiguration.text = ingredient
        
        
        cell.contentConfiguration = cellConfiguration
        
        if !viewModel.isSelected(this: ingredient){
            viewModel.removeToListOfIngredients(at: indexPath)
            cell.accessoryType = .none
        } else {
            viewModel.addToListOfIngredients(at: indexPath)
            cell.accessoryType = .checkmark
        }
    
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cellIngredient = tableView.cellForRow(at: indexPath) else {return}
        let ingredient = viewModel.ingredient(at: indexPath)
        
        if viewModel.isSelected(this: ingredient){
            viewModel.removeToListOfIngredients(at: indexPath)
            cellIngredient.accessoryType = .none
        } else {
            viewModel.addToListOfIngredients(at: indexPath)
            cellIngredient.accessoryType = .checkmark
        }
        
        createNewPizzaButton()
    }

}
