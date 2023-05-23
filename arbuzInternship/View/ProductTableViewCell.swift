//
//  ProductTableViewCell.swift
//  arbuzInternship
//
//  Created by Мирас Асубай on 18.05.2023.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "ProductTableViewCell"
    
    var product: Product?
    
    var deleteButtonActionBlock : ((UITableViewCell) -> Void)?
    
    var updateCartProductQuantity: ((Product, Double) -> Void)?
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 3
        return label
    }()
    
    let stepper: CustomStepper = {
        let stepper = CustomStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.layer.cornerRadius = 12
        stepper.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        return stepper
    }()
    
    
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 0.20)
        return button
    }()
    
    let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    let nameStepperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let deleteTotalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .trailing
//        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        print("delete button clicked")
        deleteButtonActionBlock?(self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        contentView.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
        contentView.isUserInteractionEnabled = true
    }
    
    
    
    private func setup() {
        [productNameLabel, stepper].forEach{ nameStepperStackView.addArrangedSubview($0) }
        [deleteButton, totalPriceLabel].forEach{ deleteTotalStackView.addArrangedSubview($0) }
        [productImageView, nameStepperStackView, deleteTotalStackView].forEach{ contentView.addSubview($0) }
        setConstraints()
    }
    
    private func setConstraints() {
        let margins = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: margins.topAnchor),
            productImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            productImageView.widthAnchor.constraint(equalToConstant: 120),
            
            nameStepperStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor),
            nameStepperStackView.topAnchor.constraint(equalTo: margins.topAnchor),
            nameStepperStackView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            
            deleteTotalStackView.leadingAnchor.constraint(equalTo: nameStepperStackView.trailingAnchor),
            deleteTotalStackView.topAnchor.constraint(equalTo: margins.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            deleteButton.topAnchor.constraint(equalTo: margins.topAnchor),
            
//            stepper.bottomAnchor.constraint(equalTo: bottomAnchor),
            totalPriceLabel.leadingAnchor.constraint(equalTo: deleteTotalStackView.leadingAnchor, constant: -20),
            totalPriceLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func set(productName: String) {
        if let product = Cart.shared.getProduct(name: productName) {
            self.product = product
            var measure: String = "шт"
            productImageView.image = product.image
            if product.isWeighable {
                measure = "кг"
            }
            productNameLabel.text = "\(product.name)\n\(measure)"
            stepper.value = Cart.shared.getQuantity(for: product)
            stepper.productWeightStep = product.weightStep
            
            totalPriceLabel.text = String(format: "%.0f", Cart.shared.getPriceForProduct(for: product)) + " тг"
        } else {
            print("Product not found")
        }
        
        print(stepper.value)
        
    }
}
