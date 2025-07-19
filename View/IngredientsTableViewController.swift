//
//  IngredientsTableViewController.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//

import UIKit

class IngredientsTableViewController: UITableViewController {

    private let viewModel: PizzasDetailViewModel
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: viewModel.cellIdentifier)
    }

    
    init(pizza: PizzaModel.Pizza){
        viewModel = PizzasDetailViewModel(pizza: pizza)
//        super.init(nibName: nil, bundle: nil)
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Ingredients"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        
        var cellConfiguration = cell.defaultContentConfiguration()
        
        cellConfiguration.text = viewModel.ingredients(at: indexPath)
        
        cell.contentConfiguration = cellConfiguration
        
        return cell
    }
}
