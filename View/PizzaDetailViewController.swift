//
//  PizzaDetailViewController.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//

import UIKit
import Lottie

class PizzaDetailViewController: UIViewController {
    
    
    private let ingredientsTableViewController: IngredientsTableViewController
    
    private let ingredientsTableView: UIView
    private let viewModel: PizzasDetailViewModel
    private lazy var animationView: LottieAnimationView = {
        let animation = LottieAnimationView(name: "PizzaAnimation.json")
        animation.contentMode = .scaleAspectFit
        animation.loopMode = .loop
        animation.play()
        
        animation.translatesAutoresizingMaskIntoConstraints = false
    
        return animation
    }()
    
    init(pizza: PizzaModel.Pizza){
        ingredientsTableViewController = IngredientsTableViewController(pizza: pizza)
        ingredientsTableView = ingredientsTableViewController.view
        viewModel = PizzasDetailViewModel(pizza: pizza)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = viewModel.name
        self.navigationController?.navigationBar.prefersLargeTitles = true

        setupView()
    }
    
    private func setupView() {
        ingredientsTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        view.addSubview(ingredientsTableView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: 200),
            animationView.heightAnchor.constraint(equalToConstant: 200),
            animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ingredientsTableView.topAnchor.constraint(equalTo: animationView.bottomAnchor),
            ingredientsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 8),
            ingredientsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            ingredientsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}
