//
//  PizzeriaDetailViewController.swift
//  PizzaPlaneta
//
//  Created by Jesús Lugo Sáenz on 25/01/25.
//

import UIKit

class PizzeriaDetailViewController: UIViewController {

    private let viewModel: PizzeriaDetailViewModel
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = viewModel.currentLocation
        return label
    }()
    
    private lazy var addressButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configuration = UIButton.Configuration.borderedProminent()
        configuration.title = "Show in maps"
        configuration.baseBackgroundColor = .red
//        configuration.baseForegroundColor = .red
        button.configuration = configuration
        
        button.addTarget(self,
                         action: #selector(didTapLocationButton),
                         for: .touchUpInside)
        
        return button
    }()
    
    init(pizzeria: PizzaModel.Pizzeria) {
        viewModel = PizzeriaDetailViewModel(pizzeria: pizzeria)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = viewModel.pizzeriaName
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        setupView()
        
    }
    
    private func setupView(){
        
        view.addSubview(addressLabel)
        
        NSLayoutConstraint.activate([
            addressLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        if let _ = viewModel.coordinates {
            view.addSubview(addressButton)
            
            NSLayoutConstraint.activate([
                addressButton.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
                addressButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        }
    }
    
    @objc
    func didTapLocationButton() {
        
        guard let coordinates = viewModel.coordinates else { return }
        
        let pizzeriaMapViewController = PizzeriaMapViewController(pizzeriaLocation: coordinates)
        
        present(pizzeriaMapViewController, animated: true)
    }
    
}
