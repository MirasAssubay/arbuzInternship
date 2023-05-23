//
//  ProductCollectionViewCell.swift
//  arbuzInternship
//
//  Created by Мирас Асубай on 18.05.2023.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "ProductCollectionViewCell"
    
    var product: Product = Product(image: UIImage(named: "butter")!, name: "Масло Простоквашино сливочное 82% 180 г", price: 1830, isAvailable: true)
    
    var addProductToCart: ((Product, Double) -> Void)?
    
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 2
        return label
    }()
    
    let priceButton: UIButton = {
        let button = UIButton()
        button.isHidden = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        button.setTitleColor(.black, for: .normal)
        
        return button
    }()
    
    let notAvailableButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        button.setTitleColor(.black, for: .normal)
        button.setTitle(" Нет в наличии ", for: .normal)
        return button
    }()
    
    @objc func priceButtonTapped() {
        priceButton.isHidden = true
        stepper.isHidden = false
        stepper.value += product.weightStep
        updateStepperVisibility()
    }
    
    let stepper: CustomStepper = {
        let stepper = CustomStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.isHidden = true
        stepper.layer.cornerRadius = 12
        stepper.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        return stepper
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        updateStepperVisibility()
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setConstraints()
        updateStepperVisibility()
        stepper.addTarget(self, action: #selector(stepperValueChanged), for: .valueChanged)
        
    }
    
    func setConstraints() {
        
        priceButton.addTarget(self, action: #selector(priceButtonTapped), for: .touchUpInside)
        [productImageView, productNameLabel, priceButton, stepper, notAvailableButton].forEach { addSubview($0) }

        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            
            productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            priceButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            priceButton.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor),
            priceButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            stepper.leadingAnchor.constraint(equalTo: leadingAnchor),
            stepper.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor),
            stepper.widthAnchor.constraint(equalTo: priceButton.widthAnchor),
//            stepper.trailingAnchor.constraint(equalTo: trailingAnchor),
            stepper.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            notAvailableButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            notAvailableButton.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor),
            notAvailableButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func set(product: Product) {
        self.product = product
        productImageView.image = product.image
        productNameLabel.text = product.name
        priceButton.setTitle("    \(String(product.price)) тг +    ", for: .normal)
        
        stepper.productWeightStep = product.weightStep
        
        updateStepperVisibility()
        
        if !product.isAvailable {
            priceButton.isHidden = true
            stepper.isHidden = true
            notAvailableButton.isHidden = false
        }
    }
    
    @objc func stepperValueChanged() {
        let quantity = stepper.value
        addProductToCart?(product, quantity)
        updateStepperVisibility()
    }
    
    func updateStepperVisibility() {
        stepper.isHidden = stepper.value <= 0.3
        priceButton.isHidden = !stepper.isHidden
    }
}
