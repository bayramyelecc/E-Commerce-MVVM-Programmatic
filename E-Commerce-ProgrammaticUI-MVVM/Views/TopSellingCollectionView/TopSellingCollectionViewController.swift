//
//  TopSellingCollectionViewController.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 18.11.2024.
//

import UIKit

class TopSellingCollectionViewController: UICollectionView {

    var viewModel = MainViewModel()
        
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopSellingCollectionViewController: SetupProtocol {
    func setup() {
        configure()
        drawUI()
        makeLayout()
    }
    
    func configure() {
        self.delegate = self
        self.dataSource = self
        self.register(TopSellingCollectionViewCell.self, forCellWithReuseIdentifier: TopSellingCollectionViewCell.identifier)
        
        self.showsHorizontalScrollIndicator = false
        self.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func drawUI() {
        self.backgroundColor = .systemBackground
    }
    
    func makeLayout() {
        
    }
}

extension TopSellingCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.topList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopSellingCollectionViewCell.identifier, for: indexPath) as! TopSellingCollectionViewCell
        let product = viewModel.topList[indexPath.row]
        cell.configure(with: product)
        cell.backgroundColor = .lightGray.withAlphaComponent(0.2)
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 170
        return CGSize(width: width, height: 290)
    }
}


