//
//  Cart.swift
//  arbuzInternship
//
//  Created by Мирас Асубай on 20.05.2023.
//

import Foundation

//protocol CartDelegate: AnyObject {
//    func cartDidChange()
//}

struct Cart {
    static var shared = Cart()

    var products: [Product: Double]
    let productsQueue = DispatchQueue(label: "com.example.cart.productsQueue")

//    weak var delegate: CartDelegate?

    private init() {
        products = [:]
    }

    func getProduct(name: String) -> Product? {
        return productsQueue.sync {
            return products.keys.first { $0.name == name }
        }
    }
    
    func getProduct(at indexPath: IndexPath) -> Product? {
        return productsQueue.sync {
            let allProducts = Array(products.keys)
            guard indexPath.row < allProducts.count else {
                return nil
            }
            return allProducts[indexPath.row]
        }
    }

    func getAll() -> Int {
        return productsQueue.sync {
            return products.count
        }
    }
    
    mutating func removeProduct(_ product: Product) {
        products.removeValue(forKey: product)
    }

    mutating func removeAll() {
        products.removeAll()
    }
    
    mutating func setProduct(_ product: Product, quantity: Double = 1.0) {
        productsQueue.sync {
            if quantity <= 0.3 {
                products.removeValue(forKey: product)
            } else {
                products[product] = quantity
            }
//            delegate?.cartDidChange()
        }
        print(products)
    }

    func getPriceForProduct(for product: Product) -> Double {
        return productsQueue.sync {
            guard let quantity = products[product] else {
                return 0
            }
            return Double(product.price) * quantity
        }
    }

    func getQuantity(for product: Product) -> Double {
        return productsQueue.sync {
            return products[product] ?? 0
        }
    }

    func getTotalQuantity() -> Int {
        return productsQueue.sync {
            return products.count
        }
    }

    func getTotalPrice() -> Double {
        return productsQueue.sync {
            return products.reduce(0) { result, pair in
                let (product, quantity) = pair
                return result + (Double(product.price) * Double(quantity))
            }
        }
    }
}

