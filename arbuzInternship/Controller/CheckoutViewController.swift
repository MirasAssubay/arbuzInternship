//
//  CheckoutViewController.swift
//  arbuzInternship
//
//  Created by Мирас Асубай on 23.05.2023.
//

import UIKit

class CheckoutViewController: UIViewController {
    
    private let checkoutView = CheckoutView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        view.backgroundColor = .white
        self.hideKeyboardWhenTappedAround()
    }
    
    private func setupView() {
        view.addSubview(checkoutView)
        checkoutView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            checkoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            checkoutView.topAnchor.constraint(equalTo: view.topAnchor),
            checkoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            checkoutView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
