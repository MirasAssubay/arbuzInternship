//
//  Product.swift
//  arbuzInternship
//
//  Created by Мирас Асубай on 19.05.2023.
//

import Foundation
import UIKit

struct Product: Hashable {
    let image: UIImage
    let name: String
    let price: Int
    var isAvailable: Bool
    var weightStep: Double = 1.0
    var isWeighable: Bool = false
}
