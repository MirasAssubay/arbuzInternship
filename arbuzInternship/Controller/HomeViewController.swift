//
//  HomeViewController.swift
//  arbuzInternship
//
//  Created by Мирас Асубай on 18.05.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    var collectionView: UICollectionView?
    var products: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        products = fetchData()
        configureNavBar()
        setupView()
        
    }
    
    
    private func configureNavBar() {
        var image = UIImage(named: "arbuzlogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
    }
    
    
    
    private func setupView() {
        let view = UIView()
        view.backgroundColor = .white
        
        
        let padding: CGFloat = 6.0
        let width: CGFloat = self.view.bounds.width / 2 - 3 * padding
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: width, height: 250)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        collectionView?.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.reuseIdentifier)
        collectionView?.backgroundColor = .white
        view.addSubview(collectionView ?? UICollectionView())
        
        self.view = view
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as? ProductCollectionViewCell else {
            return UICollectionViewCell()
        }
        let product = products[indexPath.row]
        cell.set(product: product)
        cell.addProductToCart = {[weak self] product, quantity in
            self?.addProductToCart(product, quantity)
        }
        return cell
    }
    
    func addProductToCart(_ product: Product, _ quantity: Double) {
        Cart.shared.setProduct(product, quantity: quantity)
    }
    
    
}

extension HomeViewController {
    func fetchData() -> [Product] {
        let product1 = Product(image: UIImage(named: "butter")!, name: "Масло Простоквашино сливочное 82% 180 г", price: 1830, isAvailable: true)
        let product2 = Product(image: UIImage(named: "sourCream")!, name: "Сметана Простоквашино 15% 300 г", price: 965, isAvailable: true)
        let product3 = Product(image: UIImage(named: "milk")!, name: "Молоко Простоквашино Ультрапастеризованное 3,2% 950 мл", price: 1235, isAvailable: true)
        let product4 = Product(image: UIImage(named: "apple")!, name: "Яблоко Гренни Смит Франция кг", price: 1260, isAvailable: false, weightStep: 1.2, isWeighable: true)
        let product5 = Product(image: UIImage(named: "pear")!, name: "Груша Конференция Бельгия кг", price: 2210, isAvailable: true, weightStep: 1.2, isWeighable: true)
        let product6 = Product(image: UIImage(named: "strawberry")!, name: "Клубника Альбион 400 г", price: 2460, isAvailable: true, weightStep: 0.4, isWeighable: true)
        let product7 = Product(image: UIImage(named: "pinemelon")!, name: "Арбуз ранний кг", price: 525, isAvailable: true, weightStep: 8.0, isWeighable: true)
        
        return [product1, product2, product3, product4, product5, product6, product7]
    }
}
