//
//  CheckoutView.swift
//  arbuzInternship
//
//  Created by Мирас Асубай on 23.05.2023.
//

import UIKit

class CheckoutView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    let addressTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Адрес доставки"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 12
        textField.autocorrectionType = .no
        return textField
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Имя получателя"
        textField.layer.cornerRadius = 12
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        return textField
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Номер телефона"
        textField.layer.cornerRadius = 12
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let labelBeforeDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Последний день подписки:"
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let pickerView = UIDatePicker()
        pickerView.maximumDate = Date() + 90 * 86_400
        pickerView.minimumDate = Date() + 7 * 86_400
        pickerView.datePickerMode = .date
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    let subscriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "День недели и время доставки:"
        return label
    }()
    
    let timePicker: CustomTimePicker = {
        let timePicker = CustomTimePicker()
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        return timePicker
    }()
    
    let totalPriceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        return button
    }()
    
    @objc func totalPriceButtonTapped(_ sender: UIButton) {
        guard let addressText = addressTextField.text,
              let nameText = nameTextField.text,
              let phoneText = phoneTextField.text else {
            return
        }
        if addressText.count >= 5 && !nameText.isEmpty && phoneText.count == 18 {
            let alert = UIAlertController(title: "Спасибо за покупку", message: "Ваш заказ будет доставлятся в \(timePicker.selectedDay), \(timePicker.selectedTimeInterval)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Отлично", style: .default))
            Cart.shared.removeAll()
            self.window?.rootViewController?.present(alert, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel))
            self.window?.rootViewController?.present(alert, animated: true)
        }
    }
    
    
    private func setup() {
        phoneTextField.delegate = self
        totalPriceButton.addTarget(self, action: #selector(totalPriceButtonTapped(_:)), for: .touchUpInside)
        [addressTextField, nameTextField, phoneTextField, labelBeforeDate, datePicker, subscriptionLabel, timePicker, totalPriceButton].forEach{ addSubview($0) }
        totalPriceButton.setTitle(String(format: "%.0f", Cart.shared.getTotalPrice()) + " тг", for: .normal)
        let margins = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            addressTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            addressTextField.topAnchor.constraint(equalTo: margins.topAnchor),
            addressTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            phoneTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            phoneTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            phoneTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            labelBeforeDate.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 15),
            labelBeforeDate.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            
            datePicker.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            subscriptionLabel.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 10),
            subscriptionLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            subscriptionLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            timePicker.topAnchor.constraint(equalTo: subscriptionLabel.bottomAnchor),
            timePicker.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            totalPriceButton.topAnchor.constraint(equalTo: timePicker.bottomAnchor),
            totalPriceButton.widthAnchor.constraint(equalToConstant: 200),
            totalPriceButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
    }
}


//MARK: - format phoneTextField in desired state
extension CheckoutView: UITextFieldDelegate {
    func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                // mask requires a number in this place, so take the next one
                result.append(numbers[index])

                // move numbers iterator to the next index
                index = numbers.index(after: index)

            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = format(with: "+X (XXX) XXX-XX-XX", phone: newString)
        return false
    }
}
