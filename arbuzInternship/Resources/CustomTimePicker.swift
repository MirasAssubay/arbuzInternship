//
//  CustomTimePicker.swift
//  arbuzInternship
//
//  Created by Мирас Асубай on 23.05.2023.
//

import Foundation
import UIKit

// Custom Picker View to display date of the week and time interval when products will be delivered
class CustomTimePicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    let daysOfWeek = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    let timeIntervals = [
        "9:00-11:00", "11:00-13:00", "13:00-15:00", "15:00-17:00",
        "17:00-19:00", "19:00-21:00", "21:00-23:00"
    ]
    
    var selectedDay: String {
        let selectedRow = selectedRow(inComponent: 0)
        return daysOfWeek[selectedRow]
    }
    
    var selectedTimeInterval: String {
        let selectedRow = selectedRow(inComponent: 1)
        return timeIntervals[selectedRow]
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPickerView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPickerView()
    }
    
    private func setupPickerView() {
        dataSource = self
        delegate = self
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return daysOfWeek.count
        } else {
            return timeIntervals.count
        }
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return daysOfWeek[row]
        } else {
            return timeIntervals[row]
        }
    }
}
