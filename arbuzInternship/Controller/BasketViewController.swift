//
//  BasketViewController.swift
//  arbuzInternship
//
//  Created by Мирас Асубай on 18.05.2023.
//

import UIKit

class BasketViewController: UIViewController {
    private var numberOfRowInSection = 0
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        numberOfRowInSection = Cart.shared.getAll()
        button.setTitle("Перейти к оплате\n" + String(format: "%.0f", Cart.shared.getTotalPrice()) + " тг", for: .normal)
        hideTotalPriceButton()
        tableView.reloadData()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("deinit")
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 20
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.textAlignment = .center
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Корзина"
        setup()
        setupTable()
//        Cart.shared.delegate = self
    }
    
    func setup() {
        view.addSubview(tableView)
        view.addSubview(button)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        view.bringSubviewToFront(button)
        
    }
    
    func setupTable() {
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        button.addTarget(self, action: #selector(priceButtonTapped(_:)), for: .touchUpInside)
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reuseIdentifier) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        let product = Cart.shared.getProduct(at: indexPath)
        guard let product = product else {
            fatalError()
        }
        cell.set(productName: product.name)
        cell.isUserInteractionEnabled = true
        cell.selectionStyle = .none
        cell.updateCartProductQuantity = { product, newQuanity in
            Cart.shared.setProduct(product, quantity: newQuanity)
        }
        
        cell.deleteButtonActionBlock = { [weak self] aCell in
            Cart.shared.removeProduct(product)
            print(Cart.shared.products)
            self?.numberOfRowInSection = Cart.shared.getAll()
            self?.button.setTitle("Перейти к оплате\n" + String(format: "%.0f", Cart.shared.getTotalPrice()) + " тг", for: .normal)
            let actualIndexPath = tableView.indexPath(for: aCell)!
            tableView.deleteRows(at: [actualIndexPath], with: .automatic)
            self?.hideTotalPriceButton()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func hideTotalPriceButton() {
        if Cart.shared.products.count == 0 {
            button.isHidden = true
        } else {
            button.isHidden = false
        }
    }
    
}

extension BasketViewController {
    @objc func priceButtonTapped(_ sender: UIButton) {
        let vc = CheckoutViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
