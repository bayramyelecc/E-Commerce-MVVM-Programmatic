//
//  BasketCollectionViewCell.swift
//  E-Commerce-ProgrammaticUI-MVVM
//
//  Created by Bayram Yeleç on 18.11.2024.
//

import UIKit
import SnapKit

protocol BasketCellDelegate: AnyObject {
    func didTapRemoveButton(product: Product)
}

class BasketCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "BasketCollectionViewCell"
    
    weak var delegate: BasketCellDelegate?
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()
    private let favButton = UIButton()
    private let removeButton = UIButton()
    
    var viewModel = CartViewModel.shared
    var product: Product?
    var isFav: Bool = false
    var favVM = FavoritesViewModel.shared
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(favButton)
        contentView.addSubview(removeButton)
        
        favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favButton.tintColor = .purple
        favButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.width.equalTo(30)
        }
        favButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(10)
            make.width.equalTo(150)
        }
        titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.equalTo(favButton.snp.left)
        }
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(imageView.snp.right).offset(10)
            make.right.equalToSuperview()
        }
        removeButton.setTitle("Delete", for: .normal)
        removeButton.setTitleColor(.white, for: .normal)
        removeButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        removeButton.backgroundColor = .systemPurple
        removeButton.layer.cornerRadius = 10
        removeButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(20)
            make.left.equalTo(imageView.snp.right)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
        }
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    func configure(with product: Product) {
        self.product = product
        imageView.image = UIImage(named: product.image!)
        titleLabel.text = product.name
        priceLabel.text = "\(product.price) TL"
        
        isFav = favVM.favoritesList.contains(where: { $0.id == product.id })
        if isFav {
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @objc private func favButtonTapped() {
        guard let currentProduct = product else {
            print("Product is nil")
            return
        }
        isFav.toggle()
        print("Favorite button tapped for: \(currentProduct.name)")
        
        if isFav {
            favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favVM.addToFavorites(currentProduct)
        } else {
            favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            favVM.removeFromFavorites(currentProduct)
        }
    }
    
    @objc func removeButtonTapped(){
        guard let product = product else {
            return
        }
        delegate?.didTapRemoveButton(product: product)
    }
    
}
