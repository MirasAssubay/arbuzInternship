//
//  CustomStepper.swift
//  arbuzInternship
//
//  Created by Мирас Асубай on 20.05.2023.
//

import UIKit

class CustomStepper: UIControl {
    private let minusButton = UIButton(type: .system)
    private let plusButton = UIButton(type: .system)
    private let valueLabel = UILabel()
    var productWeightStep: Double = 1.0
    
    var value: Double = 0 {
        didSet {
            valueLabel.text = "\(value)"
            sendActions(for: .valueChanged)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
        setupActions()
    }
    
    private func setupUI() {
        // Configure minus button
        minusButton.setTitle("-", for: .normal)
        addSubview(minusButton)
        
        // Configure plus button
        plusButton.setTitle("+", for: .normal)
        addSubview(plusButton)
        
        // Configure value label
        valueLabel.textAlignment = .center
        addSubview(valueLabel)
        
        // Set initial label text
        valueLabel.text = "\(value)"
    }
    
    private func setupActions() {
        minusButton.addTarget(self, action: #selector(decreaseValue), for: .touchUpInside)
        plusButton.addTarget(self, action: #selector(increaseValue), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonWidth: CGFloat = 14.0
        let labelWidth: CGFloat = 40.0
        let spacing: CGFloat = 8.0
        
        if valueLabel.text == "0.0" {
            self.isHidden = true
        }
        minusButton.frame = CGRect(x: 10,
                                   y: 0,
                                   width: buttonWidth,
                                   height: bounds.height)
        
        valueLabel.frame = CGRect(x: minusButton.frame.maxX + spacing,
                                  y: 0,
                                  width: labelWidth,
                                  height: bounds.height)
        
        plusButton.frame = CGRect(x: valueLabel.frame.maxX + spacing,
                                  y: 0,
                                  width: buttonWidth,
                                  height: bounds.height)
    }
    
    @objc private func decreaseValue() {
        value -= productWeightStep
    }
    
    @objc private func increaseValue() {
        value += productWeightStep
    }
}

