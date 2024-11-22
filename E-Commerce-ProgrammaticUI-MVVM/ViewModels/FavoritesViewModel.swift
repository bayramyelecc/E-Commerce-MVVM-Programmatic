//
//  FavoritesViewModel.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 20.11.2024.
//

import Foundation

class FavoritesViewModel {

    static let shared = FavoritesViewModel()

    var favoritesList: [Product] = [] {
        didSet {
            onFavoritesListUpdated?()
        }
    }
    
    var onFavoritesListUpdated: (() -> Void)?
    
    func addToFavorites(_ product: Product) {
        if !favoritesList.contains(where: { $0.id == product.id }) {
            favoritesList.append(product)
            onFavoritesListUpdated?()
        }
    }

    func removeFromFavorites(_ product: Product) {
        if let index = favoritesList.firstIndex(where: { $0.id == product.id }) {
            favoritesList.remove(at: index)
            onFavoritesListUpdated?()
        }
    }

}
