//
//  FavoritesCollectionView.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 18.11.2024.
//

import UIKit

class FavoritesCollectionView: UICollectionView {
    
    var viewModel = FavoritesViewModel.shared
    
    init(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
        self.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoritesCollectionView: SetupProtocol {
    
    func setup() {
        configure()
        drawUI()
        makeLayout()
    }
    
    func configure() {
        self.register(FavoritesCollectionViewCell.self, forCellWithReuseIdentifier: FavoritesCollectionViewCell.identifier)
        self.delegate = self
        self.dataSource = self
        self.contentInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    
    func drawUI() {
        
    }
    
    func makeLayout() {
        
    }
    
    
}

extension FavoritesCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = viewModel.favoritesList.count
        print("Number of items in favorites: \(count)")
        return count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCollectionViewCell.identifier, for: indexPath) as! FavoritesCollectionViewCell
        print("Configuring cell for item at index: \(indexPath.row)")
        let product = viewModel.favoritesList[indexPath.row]
        cell.configure(with: product)
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 10
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2.3
        return CGSize(width: width, height: 290)
    }
}

