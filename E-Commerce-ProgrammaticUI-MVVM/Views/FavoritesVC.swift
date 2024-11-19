//
//  FavoritesVC.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 17.11.2024.
//

import UIKit
import SnapKit

class FavoritesVC: UIViewController {
    
    private let collectionView = FavoritesCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension FavoritesVC : SetupProtocol {
    func setup() {
        configure()
        drawUI()
        makeLayout()
    }
    
    func configure() {
        view.addSubview(collectionView)
    }
    
    func drawUI() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
    }
    
    func makeLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
}
