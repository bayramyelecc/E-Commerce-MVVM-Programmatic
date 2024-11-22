//
//  BasketCollectionView.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 18.11.2024.
//

import UIKit

class BasketCollectionView: UICollectionView {

    var viewModel = CartViewModel.shared
    
    weak var basketDelegate: BasketCellDelegate?
    
     init() {
         let layout = UICollectionViewFlowLayout()
         layout.scrollDirection = .vertical
         super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BasketCollectionView: SetupProtocol {
    func setup() {
        configure()
        drawUI()
        makeLayout()
    }
    
    func configure() {
        self.delegate = self
        self.dataSource = self
        
        self.register(BasketCollectionViewCell.self, forCellWithReuseIdentifier: BasketCollectionViewCell.identifier)
        self.showsVerticalScrollIndicator = false
    }
    
    func drawUI() {
        
    }
    
    func makeLayout() {
        
    }
    
}

extension BasketCollectionView : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cartList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasketCollectionViewCell.identifier, for: indexPath) as! BasketCollectionViewCell
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 20
        cell.configure(with: viewModel.cartList[indexPath.row])
        cell.delegate = basketDelegate
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 140)
    }
    
}
