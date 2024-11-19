//
//  Product.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 18.11.2024.
//

import Foundation

struct Product {
    let id: String
    let name: String
    let price: Double
    let category: String
    let image: String?
    let newTop: String?
    var isFavorite: Bool = false
}


