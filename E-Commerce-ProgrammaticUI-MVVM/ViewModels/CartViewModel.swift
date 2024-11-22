//
//  CartViewModel.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 21.11.2024.
//

import Foundation

class CartViewModel {
    
    static let shared = CartViewModel()
    
    var onCartUpdated: (() -> Void)?
    
    var cartList : [Product] = [] {
        didSet {
            onCartUpdated?()
        }
    }
    
    func addToCart(_ product: Product) {
        if !cartList.contains(where: { $0.id == product.id }) {
            cartList.append(product)
            onCartUpdated?()
        }
    }

    
    func removeFromCart(_ product: Product) {
        if let index = cartList.firstIndex(where: { $0.id == product.id }) {
            cartList.remove(at: index)
            onCartUpdated?()
        }
    }
    
    
    
}
