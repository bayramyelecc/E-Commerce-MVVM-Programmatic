//
//  MainViewModel.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 18.11.2024.
//

import Foundation

class MainViewModel {
    
    var onTopSellingListUpdated: (() -> Void)?
    
    let categories: [Categories] = [
        Categories(name: "Hoodies", image: "hoodies"),
        Categories(name: "Shorts", image: "shorts"),
        Categories(name: "Shoes", image: "shoes"),
        Categories(name: "Bags", image: "bags"),
        Categories(name: "Accessories", image: "accessories")
    ]
    
    var products: [Product] = [
        Product(id: "4", name: "Shoe", price: 300, category: "Shoes", image: "shoe1", newTop: "top"),
        Product(id: "5", name: "Accessories", price: 1250, category: "Accessories", image: "accessorie1", newTop: "top"),
        Product(id: "1", name: "Short", price: 599, category: "Shorts", image: "short1", newTop: "top"),
        Product(id: "2", name: "Bag", price: 1299, category: "Bags", image: "bag1", newTop: "top"),
        Product(id: "3", name: "Hoodie", price: 359, category: "Hoodies", image: "hoodie1", newTop: "top"),
        
        Product(id: "6", name: "Hoodie", price: 455, category: "Hoodies", image: "hoodie2", newTop: "new"),
        Product(id: "7", name: "Bag", price: 699, category: "Bags", image: "bag2", newTop: "new"),
        Product(id: "8", name: "Short", price: 320, category: "Shorts", image: "short2", newTop: "new"),
        Product(id: "9", name: "Accessories", price: 750, category: "Accessories", image: "accessorie2", newTop: "new"),
        Product(id: "10", name: "Shoe", price: 1650, category: "Shoes", image: "shoe2", newTop: "new")
    ]
    
    lazy var topList: [Product] = {
        return products.filter { $0.newTop == "top" }
    }()
    
    lazy var newList: [Product] = {
        return products.filter { $0.newTop == "new" }
    }()
    
    func products(category: String) -> [Product] {
        return products.filter { $0.category == category }
    }
    
    var searchFilterItems : [Product] = []
    
    func filterProducts(name: String) {
        searchFilterItems = products.filter { $0.name.contains(name) }
    }
}
